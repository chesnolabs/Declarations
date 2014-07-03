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
             title:(NSString *)title
             units:(NSString *)units;

@property (readonly) NSString *code;
@property (readonly) NSString *units;
@property (readonly) NSString *title;

@property (readonly) id value;

@end
