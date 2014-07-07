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
@property (strong) NSURL *chesnoLink;

@end

static NSString *const DCChesnoLink = @"http://chesno.org/persons/json";

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
        _chesnoLink = [NSURL URLWithString:DCChesnoLink];
        
        _delegate = delegate;
    }
    
    return self;
}

#pragma mark -

- (void)loadPersonsWithCompletionHandler:(void (^)(NSArray *persons)) completionHandler
{
    NSLog(@"Start loading data from %@", self.chesnoLink);

    NSMutableArray *loadedPersons = [NSMutableArray array];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.chesnoLink];
    // setup request for all persons here
    
    __block id jsonResponse = nil;
    __block NSString *stringData = nil;

    NSURLSessionDataTask *allPersonsTask = [self.session dataTaskWithRequest:request
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error == nil && data != nil)
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
                        completionHandler(loadedPersons);
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
            NSLog(@"Error performing request %@", error);
        }
    }];
    
    [allPersonsTask resume];
}

- (void)loadDataForPerson:(DCPerson *)person completionHandler:(void (^)(BOOL success))block
{
    NSString *urlString = [NSString stringWithFormat:@"http://chesno.org/person/json/declarations_for/%lu", (unsigned long)person.identifier];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
                             //[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"declaration_example" ofType:@"dat"]]];
    
    // setup request for defined person
    NSURLSessionDataTask *personInfoTask = [self.session dataTaskWithRequest:request
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error == nil && data != nil)
        {
            [person removeAllDeclarations];
            NSError *parsingJSONError;
            NSArray *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:&parsingJSONError];
            
            if (jsonResponse != nil && jsonResponse.count)
            {
                // just demo depends on future json structure
                NSDictionary *declarationInfo = jsonResponse[0];
                DCDeclaration *newDeclaration = [[DCDeclaration alloc] initWithJSONObject:declarationInfo];
                [person addDeclaration:newDeclaration];
                
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
