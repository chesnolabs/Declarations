//
//  DCDeclaration.m
//  Declarations
//
//  Created by Vera Tkachenko on 5/20/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCDeclaration.h"

static NSString *const MHDeclarationYearKey = @"year";
static NSString *const MHDeclarationURLKey = @"url";
static NSString *const MHDeclarationIDKey = @"id";
static NSString *const MHDeclarationCommentKey = @"comment";
static NSString *const MHDeclarationFieldsKey = @"fields";

@implementation DCDeclaration

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {

    }
    
    return self;
}

- (id)initWithJSONObject:(NSDictionary *)jsonObject
{
    self = [super init];
    
    if (self != nil)
    {
        [self setupWithJSON:jsonObject];
    }
    
    return self;
}

- (void)setupWithJSON:(NSDictionary *)jsonObject
{
    _year = [[jsonObject objectForKey:MHDeclarationYearKey] integerValue];
    
    NSString *url = [jsonObject objectForKey:MHDeclarationURLKey];
    if (url != nil)
    {
        _originalURL = [NSURL URLWithString:url];
    }
    
    NSDictionary *model = [jsonObject objectForKey:MHDeclarationFieldsKey];
    
    NSLog(@"model = %@", model);
}

- (NSString *)title
{
    if (_title == nil)
    {
        _title = [NSString stringWithFormat:@"%lu", (unsigned long)self.year];

    }
    return _title;
}

@end
