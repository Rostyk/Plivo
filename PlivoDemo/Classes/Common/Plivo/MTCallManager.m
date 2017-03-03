//
//  MTCallManager.m
//  PlivoDemo
//
//  Created by Rostyslav.Stepanyak on 3/3/17.
//  Copyright © 2017 Rostyslav.Stepanyak. All rights reserved.
//

#import "MTCallManager.h"
#import "PlivoDemo-Swift.h"
#import "Phone.h"
#import "MTErrorBuilder.h"
#import "PlivoOutgoing.h"

@interface MTCallManager()
@property (nonatomic, strong) NSMutableArray *callLegs;
@end

@implementation MTCallManager
static MTCallManager *_manager = nil;

#pragma mark - Lifecycle

+ (MTCallManager *)shared {
    if(!_manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _manager = [[self alloc] init];
        });
    }
    return _manager;
}

- (id)init {
    self = [super init];
    _phone = [[Phone alloc] init];
    return self;
}

#pragma mark - Main calling actions

- (void)makeCall:(MTContact *)contact
      completion:(MTCallOperationCompletion)completion {
    
    if (!contact || contact.getPrimaryPhone.length == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error = [MTErrorBuilder errorWithReason:@"Cant make a call"
                                                     message:@"Your contact has no phone number"];
            completion(false, error);
            return;
        });
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        /* set extra headers */
        NSDictionary *extraHeaders = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      @"Value1", @"X-PH-Header1",
                                      @"Value2", @"X-PH-Header2",
                                      nil];
        PlivoOutgoing *callLeg = [self.phone callWithDest:contact.getPrimaryPhone
                                               andHeaders:extraHeaders];
        [self.callLegs addObject:callLeg];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!callLeg) {
                NSError *error = [MTErrorBuilder errorWithReason:@"Call failed"
                                                         message:@"Calleg not crated by Plivo"];
                completion(false, error);
            }
            else {
                completion(true, nil);
            }
        });
    });
}

- (void)hangUp {
    for (PlivoOutgoing *callLeg in self.callLegs) {
        [callLeg hangup];
    }
    
    [self.callLegs removeAllObjects];
}

- (void)disableAudio {
    for (PlivoOutgoing *callLeg in self.callLegs) {
        [callLeg hold];
    }
}

- (void)endableAudio {
    for (PlivoOutgoing *callLeg in self.callLegs) {
        [callLeg unhold];
    }
}

- (void)restoreAudio {
    for (PlivoOutgoing *callLeg in self.callLegs) {
        [callLeg unhold];
    }
}

- (void)mute {
    for (PlivoOutgoing *callLeg in self.callLegs) {
        if (callLeg.muted) {
            [callLeg unmute];
        }
        else {
            [callLeg mute];
        }
    }
}

- (void)speaker:(BOOL)speakerOn {
    /*for (PlivoOutgoing *callLeg in self.callLegs) {
        [callLeg switchOutputToSpeaker];
    }*/
}

- (void)prepare {
    [self.phone login];
    _prepared = true;
}


#pragma mark - access overrides 

- (void)setDelegate:(id<CallDelegate>)delegate {
    _delegate = delegate;
    
    [_phone setDelegate:_delegate];
}

- (NSMutableArray *)callLegs {
    if (!_callLegs) {
        _callLegs = [[NSMutableArray alloc] init];
    }
    
    return _callLegs;
}

@end
