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

static NSString *const DCChesnoLink = @"";

@implementation DCDataLoader

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:configuration];
        _chesnoLink = [NSURL URLWithString:DCChesnoLink];
    }
    
    return self;
}

#pragma mark -

- (NSArray *)loadPersons
{
    NSMutableArray *loadedPersons = [NSMutableArray array];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.chesnoLink];
    // setup request for all persons here
    
    __block id jsonResponce;
    
    NSURLSessionDataTask *allPersonsTask = [self.session dataTaskWithRequest:request
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error == nil && data != nil)
        {
            NSError *parsingJSONError;
            jsonResponce = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingAllowFragments
                                                             error:&parsingJSONError];
            if (parsingJSONError != nil)
            {
                NSLog(@"Error parsing json server responce %@", parsingJSONError);
            }
        }
        else
        {
            NSLog(@"Error performing request %@", error);
        }
    }];
    
    while (allPersonsTask.state == NSURLSessionTaskStateRunning)
    {
        [NSThread sleepForTimeInterval:0.2];
    }
    
    if ([jsonResponce isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *personJSONObject in jsonResponce)
        {
            DCPerson *newPerson = [[DCPerson alloc] initWithJSONObject:personJSONObject];
            [loadedPersons addObject:newPerson];
        }
    }
    
    return [loadedPersons copy];
}

- (void)loadDataForPerson:(DCPerson *)person
{
    
}

@end
