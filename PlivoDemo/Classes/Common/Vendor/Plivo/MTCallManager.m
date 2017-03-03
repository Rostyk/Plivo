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

- (void)makeCall:(MTContact *)contact {
    contact.getPrimaryPhone;
}

- (void)disableAudio {
    
}

- (void)endableAudio {
    
}

- (void)restoreAudio {
    
}

@end
