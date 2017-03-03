//
//  MTErrorBuilder.h
//  PlivoDemo
//
//  Created by Rostyslav.Stepanyak on 3/3/17.
//  Copyright © 2017 Rostyslav.Stepanyak. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MT_CALL_ERROR_DOMAIN @"dPlivoCallError"

@interface MTErrorBuilder : NSObject

+ (NSError *)errorWithReason:(NSString *)reason
                     message:(NSString *)message;
@end
