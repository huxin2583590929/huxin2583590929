//
//  _LPMediaPlayer.h
//  BJLiveCore
//
//  Created by MingLQ on 2016-04-26.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BJLiveBase/NSObject+BJLObserving.h>

#import "_LPRoomServer.h"
#import "_LPMediaUser.h"
#import "_LPMasterLoginModel.h"
#import "_LPMediaServerModel.h"
#import "_LPMediaInfo.h"
#import "_LPLinkInfo.h"
#import "_LPLogLinkInfo.h"
#import "_LPVideoContainerView.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT const NSUInteger _LP_DEFAULT_TCP_PORT;

// default: 4.0 / 3.0
static inline CGFloat BJLAspectRatio(CGSize size) {
    return ((size.width > 0.0 && size.height > 0.0)
            ? (size.width / size.height)
            : (4.0 / 3.0));
}

typedef NS_ENUM(NSInteger, BJLStreamID) {
    BJLStreamID_original        = 0, // definition-index 为 0
    BJLStreamID_secondCamera    = 1, // 第二摄像头
    BJLStreamID_audioRemixed    = 2, // 混音
    // 3 - 7 暂未使用
    BJLStreamID_lowDefinition1  = 8, // 对应 definition-index 1
    BJLStreamID_lowDefinition2  = 9, // 对应 definition-index 2，预留
    // !!!: 更大的数字为预留字段，切勿随意使用，需要做好保护限制
    BJLStreamID_count
};

static inline BJLStreamID BJLStreamIDFromDefinitionIndex(NSInteger index) {
    // 非 0 的 definition-index + 偏移常量 7
    const NSInteger offset = 7;
    return (index >= 1 && index <= 2
            ? (BJLStreamID)(index + offset)
            : BJLStreamID_original);
}

@interface _LPMediaPlayer : NSObject

@property (class, nonatomic) BOOL disableAVSDK;

@property (nonatomic, readonly) NSInteger volumeLevel; // KVO
@property (nonatomic, readonly) CGSize recordingVideoSize; // KVO

- (BJLObservable)recordingAudioPCMDataDidUpdate:(uint8_t [_Nullable])data length:(int)length;
- (BJLObservable)playingViewSizeDidChangeWithUser:(_LPMediaUser *)user
                                  playingViewSize:(CGSize)playingViewSize;

@property (nonatomic, readonly, copy) NSString *classID;
@property (nonatomic, readonly) BJLUser *user;
@property (nonatomic, readonly) BOOL canUDP2TCP;
@property (nonatomic, readwrite) BJLLinkType publishLinkType, playLinkType;
@property (nonatomic, readonly) NSInteger publishIndex;
@property (nonatomic) BOOL enablePCMData;

#pragma mark -

+ (instancetype)playerWithClassID:(NSString *)classID
                             user:(BJLUser *)user
           recordingContainerView:(_LPVideoContainerView *)recordingContainerView
                    partnerConfig:(NSDictionary *)partnerConfig
                    featureConfig:(BJLFeatureConfig *)featureConfig
                         roomInfo:(_LPRoomInfo *)roomInfo
                      masterModel:(_LPMasterLoginModel *)masterModel;

- (void)updateClassID:(NSString *)classID
                 user:(BJLUser *)user
        partnerConfig:(NSDictionary *)partnerConfig
        featureConfig:(BJLFeatureConfig *)featureConfig
             roomInfo:(_LPRoomInfo *)roomInfo
          masterModel:(_LPMasterLoginModel *)masterModel;

- (void)destroyPlayer;

#pragma mark - publish

@property (nonatomic, readonly) BOOL publishing;

- (void)setPublishAudio:(BOOL)publishAudio publishVideo:(BOOL)publishVideo;
// @see mediaPublishDidSendWithServer:isRePublish:
- (void)setPublishAudio:(BOOL)publishAudio publishVideo:(BOOL)publishVideo
         triggerPublish:(BOOL)triggerPublish isRePublish:(BOOL)isRePublish
            skipRelease:(BOOL)skipRelease;

- (void)publishWithServer:(_LPIpAddress *)publishServer;

@property (nonatomic, readwrite) BOOL useRearCamera; // iSight Camera
@property (nonatomic, readwrite) BJLVideoDefinition videoDefinition;
@property (nonatomic, readwrite) BJLVideoBeautifyLevel videoBeautifyLevel;
@property (nonatomic) BJLVideoRecordingOrientation recordingOrientation;
@property (nonatomic) BJLVideoContentMode recordingContentMode;

- (BJLObservable)requestMediaPublishWithDefinitionParams:(NSDictionary *)definitionParams isRepublish:(BOOL)isRepublish;

- (BJLObservable)requestMediaPublishTriggerWithServer:(_LPMediaServerModel *)mediaServer isRepublish:(BOOL)isRepublish skipRelease:(BOOL)skipRelease;

- (BJLObservable)requestMediaUnpublish;

#pragma mark - play

@property (nonatomic, readonly) BOOL playing;

@property (nonatomic, copy) _LPMediaUser * (^getMediaPlayingUserBlock)(NSString *userID, BJLMediaSource mediaSource);
@property (nonatomic, copy) _LPVideoContainerView * (^getVideoContainerViewBlock)(NSString *userID, BJLMediaSource mediaSource);
@property (nonatomic, copy) void(^playLagLogStatBlock)(_LPLogLinkInfo *logLinkInfo, NSString *userID);
@property (nonatomic, copy) void(^playSwitchLogStatBlock)(_LPLogLinkInfo *logLinkInfo, NSString *userID);
@property (nonatomic, copy) void(^downConnectFailedLogStatBlock)(_LPLogLinkInfo *logLinkInfo, NSString *userID);
@property (nonatomic, copy) void(^pullStreamFailedLogStatBlock)(_LPLogLinkInfo *logLinkInfo, NSString *userID);
@property (nonatomic) BJLVideoContentMode playingContentMode;
@property (nonatomic, readonly) NSTimeInterval playBufferTime;

// stopPlaying if no audio or video to play, return playingView
- (nullable _LPVideoContainerView *)updatePlayingForUser:(_LPMediaUser *)user playVideo:(BOOL)playVideo tcpServer:(_LPIpAddress *)tcpServer streamID:(BJLStreamID)streamID;
- (_LPVideoContainerView *)playingViewWithUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
- (CGSize)playingViewSizeWithUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
- (void)stopPlayingForUserWithID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
- (void)stopPlayingForAllUsers;
- (void)mutePlayingAudio:(BOOL)mute;
- (BJLObservable)playingUserDidStartLoadingVideo:(_LPMediaUser *)user;
- (BJLObservable)playingUserDidFinishLoadingVideo:(_LPMediaUser *)user;
- (BJLObservable)playLagWithPlayingUser:(_LPMediaUser *)user;

- (NSString *)playForUser:(_LPMediaUser *)user linkType:(BJLLinkType)linkType playServer:(_LPIpAddress *)playServer;
- (BJLObservable)requestMediaSubscribeForUser:(_LPMediaUser *)user definitionKey:(BJLLiveDefinitionKey)definitionKey isReplay:(BOOL)isReplay;

#pragma mark - buffer

- (NSTimeInterval)getPlayingBuffer;

#pragma mark - debug

@property (nonatomic) void(^reportCallback)(NSString *message);

@property (nonatomic, readonly) NSTimeInterval currentBuffer;

@property (nonatomic, readonly) _LPLinkInfo *publishLinkInfo;
@property (nonatomic, readonly) NSMutableDictionary<NSString *, _LPMediaInfo *> *playMediaInfos;

@property (nonatomic, readonly) _LPLinkInfo *teacherLinkInfo;

- (_LPLinkInfo *)linkInfoWithUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
- (NSArray<_LPLinkInfo *> *)allLinkInfos; // 包含辅助摄像头的流

- (NSInteger)publishFPS; // 当前推流的FPS

#pragma mark - weak network

- (CGFloat)getVideoLossRateWithUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;

- (CGFloat)getAudioLossRateWithUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;

@end

NS_ASSUME_NONNULL_END
