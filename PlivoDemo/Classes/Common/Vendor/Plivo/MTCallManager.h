//
//  MTCallManager.h
//  PlivoDemo
//
//  Created by Rostyslav.Stepanyak on 3/3/17.
//  Copyright © 2017 Rostyslav.Stepanyak. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTContact;
@class Phone;

@interface MTCallManager : NSObject
@property (nonatomic, strong, readonly) Phone *phone;

/**
 * Get the shared instance of the call manager
 * @return An initialized instance of the call manager
 */
+ (MTCallManager *)shared;

#pragma mark - Main calling actions

/**
 * Trigger the call
 * @param contact The participants of the call
 */
- (void)makeCall:(MTContact *)contact;

- (void)disableAudio;
- (void)endableAudio;
- (void)restoreAudio;
@end
