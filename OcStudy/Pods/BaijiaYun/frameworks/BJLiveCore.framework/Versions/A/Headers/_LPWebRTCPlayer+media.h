//
//  _LPWebRTCPlayer+media.h
//  BJLiveCore
//
//  Created by xijia dai on 2020/8/7.
//  Copyright © 2020 BaijiaYun. All rights reserved.
//

#import "_LPWebRTCPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPWebRTCPlayer (media)

// 更新当前的推拉流状态
- (void)updatePublishing:(BOOL)publishing;
- (void)updatePlaying:(BOOL)playing;

// 获取 user
- (nullable _LPMediaUser *)mediaUserWithUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
// 获取音视频播放状态
- (BOOL)playVideoWithUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;
- (BOOL)playAudioWithUserID:(NSString *)userID mediaSource:(BJLMediaSource)mediaSource;

// 缓存采集和播放状态
- (void)updateAutoPlayUsersWithUser:(_LPMediaUser *)user
                           autoPlay:(BOOL)autoPlay
                          playVideo:(BOOL)playVideo;

- (void)updateAutoPlayUsersWithUser:(_LPMediaUser *)user
                           autoPlay:(BOOL)autoPlay
                          playAudio:(BOOL)playAudio;

- (void)updateLoginUserRecordingAudio:(BOOL)recordingAudio
                       recordingVideo:(BOOL)recordingVideo
                       triggerPublish:(BOOL)triggerPublish
                          isRePublish:(BOOL)isRePublish
                          skipRelease:(BOOL)skipRelease;

// 加入频道后刷新缓存的采集和播放状态
- (void)autoPlayAndRecording;

- (void)autoPlayUser:(_LPMediaUser *)user play:(BOOL)autoPlay;

@end

NS_ASSUME_NONNULL_END
