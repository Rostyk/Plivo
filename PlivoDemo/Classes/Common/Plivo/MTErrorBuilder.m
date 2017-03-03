//
//  MTErrorBuilder.m
//  PlivoDemo
//
//  Created by Rostyslav.Stepanyak on 3/3/17.
//  Copyright © 2017 Rostyslav.Stepanyak. All rights reserved.
//

#import "MTErrorBuilder.h"

@implementation MTErrorBuilder

+ (NSError *)errorWithReason:(NSString *)reason
                     message:(NSString *)message {
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: reason,
                               NSLocalizedFailureReasonErrorKey: message,
                               NSLocalizedRecoverySuggestionErrorKey: @""
                               };
    NSError *error = [NSError errorWithDomain:MT_CALL_ERROR_DOMAIN
                                         code:-1
                                     userInfo:userInfo];
    
    return error;
}

@end
