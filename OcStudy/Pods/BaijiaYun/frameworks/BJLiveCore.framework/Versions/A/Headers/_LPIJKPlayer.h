//
//  _LPIJKPlayer.h
//  BJLiveCore
//
//  Created by xijia dai on 2020/10/29.
//  Copyright © 2020 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BJYRTCEngine/BJYRTCEngine.h>

#import "_LPMediaUser.h"
#import "_LPVideoContainerView.h"
#import "_LPLinkInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPIJKPlayer : NSObject

+ (instancetype)player;
- (void)destroyPlayer;
@property (nonatomic, copy) void (^updatePlayerInfoBlock)(void);

#pragma mark -

@property (nonatomic, readonly) BOOL playing;
@property (nonatomic) CGFloat audioVolume;
@property (nonatomic, readonly) BOOL streamMute;
@property (nonatomic, readonly) BOOL volumeMute;
@property (nonatomic, readonly) NSTimeInterval maxBufferTime;
@property (nonatomic) BJLVideoContentMode playingContentMode;
@property (nonatomic) BOOL supportMediaSource;

#pragma mark -

@property (nonatomic, copy, nullable) void (^playFailedBlock)(NSInteger playID);
@property (nonatomic, copy, nullable) void (^playingViewSizeChangeBlock)(NSInteger playID, CGSize size);
@property (nonatomic, copy, nullable) void (^playingSuccessBlock)(NSInteger playID);
@property (nonatomic, copy, nullable) void (^firstVideoFrameRenderedBlock)(NSInteger playID);
@property (nonatomic, copy, nullable) void (^playLagLogStatBlock)(NSInteger playID);

#pragma mark -

- (NSInteger)updatePlayingForUser:(_LPMediaUser *)user
                        playVideo:(BOOL)playVideo
                    playURLString:(NSString *)playURLString
                    containerView:(_LPVideoContainerView *)containerView;

- (NSInteger)updatePlayingForUser:(_LPMediaUser *)user
                        playVideo:(BOOL)playVideo
                    playURLString:(NSString *)playURLString
                    containerView:(_LPVideoContainerView *)containerView
                           replay:(BOOL)replay;

- (void)stopPlayingForUser:(_LPMediaUser *)user;
- (void)stopPlayingForUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
- (void)mutePlayingAudio:(BOOL)mute;
- (void)updateMaxBufferTime:(NSTimeInterval)maxBufferTime;

#pragma mark -

- (CGSize)playingViewSizeWithLinkInfo:(_LPLinkInfo *)linkInfo;

#pragma mark -

- (nullable NSDictionary *)streamInfoWithLinkInfo:(_LPLinkInfo *)linkInfo;
- (nullable NSString *)streamStringInfoWithLinkInfo:(_LPLinkInfo *)linkInfo;

@end

NS_ASSUME_NONNULL_END
