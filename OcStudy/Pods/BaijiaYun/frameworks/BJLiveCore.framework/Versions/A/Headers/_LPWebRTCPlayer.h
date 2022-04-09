//
//  _LPWebRTCPlayer.h
//  BJLiveCore
//
//  Created by HuangJie on 2018/11/26.
//  Copyright © 2018 BaijiaYun. All rights reserved.
//

#import <BJYRTCEngine/BJYRTCEngine.h>

#if __has_feature(modules) && BJL_USE_SEMANTIC_IMPORT
@import BJLiveBase;
#else
#import <BJLiveBase/BJLiveBase.h>
#endif

#import "BJLConstants.h"
#import "_LPMediaUser.h"
#import "_LPMediaServerModel.h"
#import "_LPMasterLoginModel.h"
#import "BJLFeatureConfig+protected.h"
#import "_LPVideoContainerView.h"
#import "_LPLinkInfo.h"
#import "_LPLogLinkInfo.h"
#import "_BJLCloudVideo.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    BOOL recordingAudio;
    BOOL recordingVideo;
} LPMediaState;

@interface _LPWebRTCPlayer : NSObject

@property (nonatomic, readonly) BOOL inLiveChannel;
@property (nonatomic, copy) void (^updatePlayerInfoBlock)(void);

// joinRoomWithOptions 之前调用
+ (void)setBRTCURL:(nullable NSString *)brtcURL;

+ (instancetype)playerWithRecordingContainerView:(_LPVideoContainerView *)recordingContainerView
                                   featureConfig:(BJLFeatureConfig *)featureConfig;

- (void)updatePlayerWithClassID:(NSString *)classID
                           user:(BJLUser *)user
                  partnerConfig:(NSDictionary *)partnerConfig
                  featureConfig:(BJLFeatureConfig *)featureConfig
                    masterModel:(_LPMasterLoginModel *)masterModel
                    roomType:(BJLRoomType)roomType;

- (void)destroyPlayer;

- (void)joinLiveChannel;
- (void)leaveLiveChannel;

#pragma mark - publish

@property (nonatomic, readonly) BOOL publishing;
@property (nonatomic, readonly) CGFloat recordingRatio; // 视频采集宽高比
@property (nonatomic) BOOL useRearCamera;    // 后置摄像头
@property (nonatomic) BJLVideoDefinition videoDefinition; // 视频采集清晰度
@property (nonatomic) BJLVideoContentMode recordingContentMode;
@property (nonatomic) BJLVideoRecordingOrientation recordingOrientation;

- (void)setPublishAudio:(BOOL)publishAudio
           publishVideo:(BOOL)publishVideo;

- (void)setPublishAudio:(BOOL)publishAudio
           publishVideo:(BOOL)publishVideo
         triggerPublish:(BOOL)triggerPublish
            isRePublish:(BOOL)isRePublish
            skipRelease:(BOOL)skipRelease;

// 获取采集截图
- (void)requestPreviewImageWithUser:(_LPMediaUser *)user completion:(void (^)(UIImage *image))completion;

// 推流是否开启视频镜像
- (void)encoderSwitchMirrorMode:(BJYVideoFlipType)mode;

// 切换音频通道
- (BOOL)switchAudioTransport2Media:(BOOL)isMediaTransport;

- (BJLObservable)requestMediaPublishTriggerWithServer:(_LPMediaServerModel *)mediaServer isRepublish:(BOOL)isRepublish skipRelease:(BOOL)skipRelease;

- (BJLObservable)republishing;

- (BJLObservable)publishFailed;

#pragma mark - play

@property (nonatomic, readonly) BOOL playing;
@property (nonatomic) CGFloat audioVolume;
@property (nonatomic) BJLVideoContentMode playingContentMode;
@property (nonatomic, nullable) NSString *disablePlayAsCameraUserID;
@property (nonatomic, copy) _LPMediaUser * (^getMediaPlayingUserBlock)(NSString *userID, BJLMediaSource mediaSource);
@property (nonatomic, copy) _LPVideoContainerView * (^getVideoContainerViewBlock)(NSString *userID, BJLMediaSource mediaSource);

- (nullable _LPVideoContainerView *)updatePlayingForUser:(_LPMediaUser *)user playVideo:(BOOL)playVideo;
- (nullable _LPVideoContainerView *)updatePlayingForUser:(_LPMediaUser *)user playAudio:(BOOL)playAudio;
- (nullable _LPVideoContainerView *)playingViewWithUserID:(nullable NSString *)userID mediaSource:(BJLMediaSource)mediaSource;

- (void)stopPlayingForUserWithID:(nullable NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
- (void)stopPlayingForAllUsers;
- (void)mutePlayingAudio:(BOOL)mute;

// 拉流时切换大小流
- (void)switchVideoDefinitionWithUser:(BJLMediaUser *)user useLowDefinition:(BOOL)useLowDefinition;

// 当前用户本地预览视频镜像
- (void)renderSwitchMirrorMode:(BJYVideoFlipType)mode;

- (CGFloat)playingViewRatioWithUserID:(nullable NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
- (BJLObservable)playingViewSizeDidChange:(CGSize)playingViewSize
                                forUserID:(NSString *)userID
                              mediaSource:(BJLMediaSource)mediaSource;

- (BJLObservable)playingUserDidStartLoadingVideo:(_LPMediaUser *)user;
- (BJLObservable)playingUserDidFinishLoadingVideo:(_LPMediaUser *)user;

#pragma mark - CDN 拉流

@property (nonatomic) BOOL playMixStream;
@property (nonatomic, copy) void (^playMixedVideoSuccessBlock)(void);
@property (nonatomic, copy) void (^playMixedVideoFailedBlock)(void);
@property (nonatomic, copy) _LPVideoContainerView * (^getMixedVideoContainerViewBlock)(void);

// 获取合流延时，返回值为毫秒
- (int)getPlayMixVideoBufferTime;

- (nullable _LPVideoContainerView *)playMixedVideoWithStreamURLString:(NSString *)streamURLString
                                                               userID:(NSString *)userID
                                                            playVideo:(BOOL)playVideo
                                                  needNotReloadStream:(BOOL)needNotReloadStream;
- (void)stopPlayingMixedVideo;

#pragma mark - 播放云点播视频

@property (nonatomic) BOOL playCloudVideo;
- (nullable _LPVideoContainerView *)playCloudVideoWithCloudVideo:(BJLCloudVideo *)cloudVideo;
- (void)pauseCloudVideo:(BJLCloudVideo *)cloudVideo;
- (void)stopCloudVideo;

#pragma mark - preview

// 开启摄像头预览
- (void)startPreview;

// 关闭摄像头预览
- (void)stopPreview;

#pragma mark - media info

/**
 网络质量更新回调
 #param user    用户实例
 #param quality 网络质量
 */
- (BJLObservable)networkQualityDidUpdateWithUser:(_LPMediaUser *)user quality:(BJYRTCEngineNetworkQuality)quality;

/**
 音视频丢包率更新回调
 #param user            用户实例
 #param videoLossRate   视频丢包率 [0, 100]
 #param audioLossRate   音频丢包率 [0, 100]
 */
- (BJLObservable)mediaLossRateDidUpdateWithUser:(_LPMediaUser *)user videoLossRate:(CGFloat)videoLossRate audioLossRate:(CGFloat)audioLossRate;

/**
 音量更新回调
 #param user   用户实例
 #param volume 音量, 取值范围 0~255
 */
- (BJLObservable)volumeDidUpdateWithUser:(_LPMediaUser *)user volume:(CGFloat)volume;

#pragma mark - call back

/** 加入直播频道失败 */
- (BJLObservable)enterLiveChannelFailed;

/**
 直播频道断开连接
 #param error 断连的错误信息
 */
- (BJLObservable)didLiveChannelDisconnectWithError:(nullable NSError *)error;

#pragma mark - Debug & logstat

@property (nonatomic, copy) void (^reportBlock)(NSString *message);

@property (nonatomic, readonly, nullable) _LPLinkInfo *publishLinkInfo;

@property (nonatomic, copy) void(^downConnectFailedLogStatBlock)(_LPLogLinkInfo *logLinkInfo, NSString *userID);
@property (nonatomic, copy) void(^pullStreamFailedLogStatBlock)(_LPLogLinkInfo *logLinkInfo, NSString *userID);
@property (nonatomic, copy) void(^publishFailedLogStatBlock)(_LPLogLinkInfo *logLinkInfo, NSString *userID);
@property (nonatomic, copy) void(^playLagLogStatBlock)(_LPLogLinkInfo *logLinkInfo);

// BJYRTCEngin扩展配置项, tools中配置, BJLiveCore 仅仅透传
@property (nonatomic, strong) NSString *rtcExtConfig;

- (NSArray <_LPLinkInfo *> *)allLinkInfos; // 包含辅助摄像头的流

- (nullable NSString *)getDebugInfoWithUserID:(NSString *)userID
                                     userName:(NSString *)userName
                                  mediaSource:(BJLMediaSource)mediaSource;

- (void)reconnectChannelWithMediaServer:(NSString *)mediaServer;

- (NSInteger)publishFPS; // 当前推流的FPS

- (CGFloat)getVideoLossRateWithUserID:(NSString *)userID
                          mediaSource:(BJLMediaSource)mediaSource;

- (CGFloat)getAudioLossRateWithUserID:(NSString *)userID
                          mediaSource:(BJLMediaSource)mediaSource;

/// 返回音视频推拉流的相关统计信息
/// @param qosDic <userid:qosinfoDic, userid:qosinfoDic...> 这种形式的字典，包含当前推流用户
/// qosinfoDic 中 key 是 BJYRTCKeys.h 中定义的，主要有LossRate、 BufferLength、 Interframe、 Bandwidth
/// @param sessionType sessionType当前只有BJYRTCSessionType_Camera_Main 有效
- (BJLObservable)didReceiveQosDic:(NSDictionary *)qosDic sessionType:(BJYRTCSessionType)sessionType;
@end

NS_ASSUME_NONNULL_END
