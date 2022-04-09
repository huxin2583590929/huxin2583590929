//
//  _LPMediaPlayer+control.h
//  BJLiveCore
//
//  Created by MingLQ on 2016-04-27.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#if __has_include(<BJHLMediaPlayer/gsx_rtc_types.h>)
    #import <BJHLMediaPlayer/gsx_rtc_types.h>
#else
    #import "gsx_rtc_types.h"
#endif

#import "_LPMediaPlayer.h"

typedef struct {
    int firstSwitchLimit, firstSwitchOffset, playSwitchLimit, playSwitchOffset;
}
_LPSwitchConfig;

static inline _LPSwitchConfig _LPSwitchConfigMake(int firstSwitchLimit,
                                                int firstSwitchOffset,
                                                int playSwitchLimit,
                                                int playSwitchOffset) {
    return (_LPSwitchConfig){firstSwitchLimit, firstSwitchOffset, playSwitchLimit, playSwitchOffset};
}

static const GsxLivePlayInfo GsxLivePlayInfoNull = (GsxLivePlayInfo){};
static inline BOOL GsxLivePlayInfoIsNull(GsxLivePlayInfo playInfo) {
    return memcmp(&playInfo, &GsxLivePlayInfoNull, sizeof(GsxLivePlayInfo)) == 0;
}

#pragma mark -

@interface _LPMediaPlayer (control)

@property (nonatomic, readonly) UIView *recordingView;

#pragma mark - setUp & config

- (void)setUpPlayer;
- (void)teardownPlayer;

- (void)updateLocalUser;
- (void)updateSwitchConfig:(_LPSwitchConfig)switchConfig;
- (void)updatePlayingBuffer:(NSTimeInterval)seconds;
- (void)setupLiveAudioCodec:(NSInteger)liveAudioCodec; // 设置音频编码
- (void)setRecordingVolumeLevel:(CGFloat)volumeLevel; // 设置采集音量

// #return GsxLivePlayInfoNull if streamName not found, #see GsxLivePlayInfoIsNull()
- (GsxLivePlayInfo)playInfoWithStreamName:(NSString *)streamName;

#pragma mark - play

/**
 * playAV - 播放音视频
 #param  userID
 #param  playVideo
 #param  streamName
 #param  playURL          - for both TCP & UDP
 #param  userPublishIP    - for UDP only
 #param  userPublishPort  - for UDP only
 */
// - (void)toPlayAV:(NSDictionary *)payload;
- (int)playWithUserID:(int)userID
            playVideo:(BOOL)playVideo
             streamID:(BJLStreamID)streamID
           streamName:(NSString *)streamName
              playURL:(NSString *)playURL
        userPublishIP:(NSString *)userPublishIP
      userPublishPort:(NSUInteger)userPublishPort
        containerView:(_LPVideoContainerView *)containerView;
/**
 * playAVRelease - 销毁播放音视频的链路
 */
// - (void)toPlayAVRelease:(NSDictionary *)payload;
- (void)playReleaseWithPlayingStreamName:(NSString *)streamName;

- (CGSize)playingViewSizeWithPlayId:(int)playId;

#pragma mark - publish

/**
 * publishAV - 发布音视频
 * #param {string} options.streamName 需要发布的流名称
 * #param {string} options.publishIp 发布到的 live server
 * #param {number} options.publishPort 发布到的 live server
 */
// - (void)toPublishAV:(NSDictionary *)payload;
/* publishIp:(NSString *)publishIp
 * publishPort:(NSUInteger)publishPort */
- (int)publishWithStreamName:(NSString *)streamName
                   publishURL:(NSString *)publishURL;
/**
 * publishAVRelease - 停止发布音视频
 */
// - (void)toPublishAVRelease:(NSDictionary *)payload;
- (void)publishRelease;

- (void)attachAudio;
- (void)detachAudio;
- (void)muteAudio;
- (void)unmuteAudio;
- (void)muteOutputAudio:(BOOL)mute;

- (void)attachVideo;
- (void)detachVideo;
- (void)switchCamera;
- (void)updateVideoBeautifyLevel;

@end
