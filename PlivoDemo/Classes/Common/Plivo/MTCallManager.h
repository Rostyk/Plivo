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
@class PlivoOutgoing;

typedef void (^MTCallOperationCompletion)(BOOL success, NSError *error);

@protocol CallDelegate <NSObject>
- (void)onLogin;
- (void)onLoginFailed;
- (void)onOutgoingCallAnswered:(PlivoOutgoing *)call;
/*- (void)onOutgoingCallHangup:(PlivoOutgoing *)call;
- (void)onCalling:(PlivoOutgoing *)call;
- (void)onOutgoingCallRinging:(PlivoOutgoing *)call;
- (void)onOutgoingCallRejected:(PlivoOutgoing *)call;
- (void)onOutgoingCallInvalid:(PlivoOutgoing *)call;*/
@end

@interface MTCallManager : NSObject
@property (nonatomic, strong, readonly) Phone *phone;
@property (nonatomic, weak) id<CallDelegate> delegate;

/**
 * Get the shared instance of the call manager
 * @return An initialized instance of the call manager
 */
+ (MTCallManager *)shared;

#pragma mark - Main calling actions

/**
 * Trigger the call
 * @param contact The participants of the call
 * @param completion Idicates the status of the operation. In case it fails - error will contain corresponding error.
 */
- (void)makeCall:(MTContact *)contact
      completion:(MTCallOperationCompletion)completion;

/**
 * Prepares for the call
 */
- (void)prepare;

/**
 * Mute the call if umuted. Or unmute if muted
 */
- (void)mute;

/**
 * Hangs up the call
 */
- (void)hangUp;

- (void)disableAudio;
- (void)endableAudio;
- (void)restoreAudio;
@end
