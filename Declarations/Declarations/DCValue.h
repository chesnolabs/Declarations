//
//  DCValue.h
//  Declarations
//
//  Created by tanlan on 5/26/14.
//  Copyright (c) 2014 Chesno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCValue : NSObject

- (id)initWithCode:(NSString *)code
             value:(id)value
             units:(NSString *)units;

@property (readonly) NSString *code;
@property (readonly) id value;
@property (readonly) NSString *units;

@end
