//
//  DCCommutator.m
//  Declarations
//
//  Created by tanlan on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDataLoader.h"
#import "DCPerson.h"

@interface DCDataLoader ()

@property (strong) NSURLSession *session;

@end

static NSString *const DCOfficialsLink = @"http://chesno.org/persons/json/officials/";
static NSString *const DCDeputiesLink = @"http://chesno.org/persons/json/deputies/all/";
static NSString *const DCCandidatesLink = @"http://chesno.org/persons/json/presidentialcandidate/";

@implementation DCDataLoader

- (instancetype)init
{
    return [self initWithDelegate:nil];
}

- (id)initWithDelegate:(id<DCDataLoaderDelegate>)delegate
{
    self = [super init];
    
    if (self != nil)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:configuration];
        _delegate = delegate;
    }
    
    return self;
}

#pragma mark -

- (void)loadDeputiesWithCompletionHandler:(void (^)(NSArray *persons, NSError *error))completionHandler
{
    [self loadPersonsWithCompletionHandler:completionHandler url:[NSURL URLWithString:DCDeputiesLink]];
}

- (void)loadOfficialsWithCompletionHandler:(void (^)(NSArray *persons, NSError *error))completionHandler
{
    [self loadPersonsWithCompletionHandler:completionHandler url:[NSURL URLWithString:DCOfficialsLink]];
}

- (void)loadCandidatesWithCompletionHandler:(void (^)(NSArray *persons, NSError *error))completionHandler
{
    [self loadPersonsWithCompletionHandler:completionHandler url:[NSURL URLWithString:DCCandidatesLink]];
}

- (void)loadPersonsWithCompletionHandler:(void (^)(NSArray *persons, NSError *error))completionHandler url:(NSURL *)url
{
    NSLog(@"Start loading data from %@", url);

    NSMutableArray *loadedPersons = [NSMutableArray array];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // setup request for all persons here
    
    __block id jsonResponse = nil;
    __block NSString *stringData = nil;

    NSURLSessionDataTask *allPersonsTask = [self.session dataTaskWithRequest:request
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error == nil && data != nil)
        {
            NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response
                                                                                           data:data];
            
            [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
            [[NSURLCache sharedURLCache] storeCachedResponse:cachedResponse
                                                  forRequest:request];
        }
        else
        {
            NSLog(@"Error performing request: %@", error);
            
            NSCachedURLResponse *cachedResponce = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
            data = [cachedResponce data];
        }
        
        if (data != nil)
        {
            NSError *parsingJSONError = nil;
            jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingAllowFragments
                                                             error:&parsingJSONError];
            if (jsonResponse == nil)
            {
                NSLog(@"Error parsing json server response %@ data: %@", parsingJSONError, stringData);
            }
            else
            {
                if ([jsonResponse isKindOfClass:[NSArray class]])
                {
                    for (NSDictionary *personJSONObject in jsonResponse)
                    {
                        DCPerson *newPerson = [[DCPerson alloc] initWithJSONObject:personJSONObject];
                        if (newPerson != nil)
                        {
                            [loadedPersons addObject:newPerson];
                        }
                    }
                    
                    if (completionHandler != nil)
                    {
                        completionHandler(loadedPersons, nil);
                    }
                }
                else
                {
                    NSLog(@"Received JSON response of unknown type %@ data: %@", jsonResponse, stringData);
                }
            }
        }
        else
        {
            if (completionHandler != nil)
            {
                completionHandler(nil, error);
            }
        }
    }];
    
    [allPersonsTask resume];
}

- (void)loadDataForPerson:(DCPerson *)person completionHandler:(void (^)(BOOL success))block
{
    NSString *urlString = [NSString stringWithFormat:@"http://chesno.org/person/json/declarations_for/%lu", (unsigned long)person.identifier];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    // setup request for defined person
    NSURLSessionDataTask *personInfoTask = [self.session dataTaskWithRequest:request
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error == nil && data != nil)
        {
            NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response
                                                                                           data:data];
            
            [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
            [[NSURLCache sharedURLCache] storeCachedResponse:cachedResponse
                                                  forRequest:request];
        }
        else
        {
            NSCachedURLResponse *cachedResponce = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
            data = [cachedResponce data];
        }
        
        if (data != nil)
        {
            [person removeAllDeclarations];
            NSError *parsingJSONError;
            NSArray *declarationsJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:&parsingJSONError];
            
            if (declarationsJSON != nil && declarationsJSON.count)
            {
                for (id declaration in declarationsJSON)
                {
                    if ([declaration isKindOfClass:[NSDictionary class]])
                    {
                        NSDictionary *declarationInfo = (NSDictionary *)declaration;
                        DCDeclaration *newDeclaration = [[DCDeclaration alloc] initWithJSONObject:declarationInfo];
                        [person addDeclaration:newDeclaration];
                    }
                }
                
                [self.delegate dataLoader:self didFinishLoadingPerson:person];
                block(YES);
            }
            else
            {
                [self.delegate dataLoader:self didFailedLoadingPerson:person];
                block(NO);
            }
        }
        else
        {
            [self.delegate dataLoader:self didFailedLoadingPerson:person];
            block(NO);
        }
    }];
    
    [personInfoTask resume];
}

@end
