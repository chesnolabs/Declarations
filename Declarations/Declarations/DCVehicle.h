//
//  DCCar.h
//  Declarations
//
//  Created by tanlan on 7/3/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import "DCValue.h"

@interface DCVehicle : DCValue

- (id)initWithCode:(NSString *)code
              info:(NSString *)info
              mark:(NSString *)mark
             model:(NSString *)model
              year:(NSString *)year;

@property (readonly, strong) NSString *info;
@property (readonly, strong) NSString *mark;
@property (readonly, strong) NSString *model;
@property (readonly, strong) NSString *year;

@end
