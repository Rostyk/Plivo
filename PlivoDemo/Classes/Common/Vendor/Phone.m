//
//  Phone.m
//  PlivoOutgoingApp
//
//  Created by Iwan BK on 10/2/13.
//  Copyright (c) 2013 Plivo. All rights reserved.
//

#import "Phone.h"
#import "PlivoEndpoint.h"

@interface Phone()
@property (nonatomic, strong) PlivoOutgoing *outCall;
@end

@implementation Phone {
    PlivoEndpoint *endpoint;
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
    /* construct SIP URI */
    NSString *sipUri = [[NSString alloc]initWithFormat:@"sip:%@@phone.plivo.com", dest];
    
    /* create PlivoOutgoing object */
    self.outCall = [endpoint createOutgoingCall];
    
    /* do the call */
    [self.outCall call:sipUri headers:headers];
    
    return self.outCall;
}

- (void)setDelegate:(id)delegate
{
    [endpoint setDelegate:delegate];
}

- (void) disableAudio{
	[self.outCall hold];
}

- (void) enableAudio{
	[self.outCall unhold];
}

@end
