//
//  Phone.m
//  PlivoOutgoingApp
//
//  Created by Iwan BK on 10/2/13.
//  Copyright (c) 2013 Plivo. All rights reserved.
//

#import "Phone.h"
#import "PlivoEndpoint.h"

@implementation Phone {
    PlivoEndpoint *endpoint;
    PlivoOutgoing *outCall;
}

- (id) init
{
    self = [super init];
    
    if (self) {
        endpoint = [[PlivoEndpoint alloc] init];
    }
    
    return self;
}

- (void)login
{
    NSString *username = @"Test134170302204056";
    NSString *password = @"x1YY3WuW5D";
    [endpoint login:username AndPassword:password];
}

- (PlivoOutgoing *)callWithDest:(NSString *)dest andHeaders:(NSDictionary *)headers
{
    NSString *cleanedPhoneNumber = [[dest componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    /* construct SIP URI */
    NSString *sipUri = [[NSString alloc]initWithFormat:@"sip:%@@phone.plivo.com", cleanedPhoneNumber];
    
    /* create PlivoOutgoing object */
    outCall = [endpoint createOutgoingCall];
    
    /* do the call */
    [outCall call:sipUri headers:headers];
    
    return outCall;
}

- (void)setDelegate:(id)delegate
{
    [endpoint setDelegate:delegate];
}

@end
