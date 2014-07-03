//
//  DCCar.m
//  Declarations
//
//  Created by tanlan on 7/3/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCVehicle.h"

@interface DCVehicle ()

@property (readwrite, strong) NSString *info;
@property (readwrite, strong) NSString *mark;
@property (readwrite, strong) NSString *model;
@property (readwrite, strong) NSString *year;

@end

@implementation DCVehicle

- (id)initWithCode:(NSString *)code
              info:(NSString *)info
              mark:(NSString *)mark
             model:(NSString *)model
              year:(NSString *)year
{
    self = [super initWithCode:code
                         value:nil
                         title:nil
                         units:nil];
    
    if (self != nil)
    {
        _info = info;
        _mark = mark;
        _model = model;
        _year = year;
    }
    
    return self;
}

#pragma mark -

- (NSString *)description
{
    return [[super description] stringByAppendingFormat:@"[description:%@; mark:%@; model:%@; year:%@]", self.info, self.mark, self.model, self.year];
}

@end
