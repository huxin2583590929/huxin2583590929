//
//  _LPRoomServer+Media.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"
#import "_LPResMediaPublish.h"
#import "_LPResMediaSubscribe.h"
#import "_LPResMediaUnpublish.h"
#import "_LPMediaPublish.h"
#import "_LPMediaRePublish.h"
#import "_LPResMediaRemoteControl.h"
#import "_LPResMediaSpeakApply.h"
#import "_LPMediaResolution.h"
#import "_LPResVideoMirrorMode.h"

@class _LPMediaServerModel;
@class _LPMediaRemoteControlModel;

@interface _LPRoomServer () {
    id _prevMediaPublishTriggerObject;
}
@end

/**
 *  多媒体相关信令服务
 */
@interface _LPRoomServer (Media)

- (void)regitsterSelectorsForResponsesForMedia;

#pragma mark - 音视频发布 server 调度

- (void)requestMediaPublishWithDefinitionParams:(NSDictionary *)definitionParams
                                       linkType:(BJLLinkType)linkType
                                      sessionID:(NSString *)sessionID
                                     userNumber:(NSString *)userNumber
                                   preferredCDN:(NSString *)preferredCDN
                                  partnerConfig:(NSDictionary *)partnerConfig
                                      videoSize:(CGSize)videoSize;

- (BJLObservable)onResponsePublish:(_LPResMediaPublish *)response;

#pragma mark - 音视频信息发布

- (void)requestMediaPublishTriggerWithMediaServer:(_LPMediaServerModel *)mediaServer
                                             user:(BJLUser *)user
                                        sessionID:(NSString *)sessionID
                                        keepAlive:(BOOL)keepAlive
                                      skipRelease:(BOOL)skipRelease
                                     hasLowStream:(BOOL)hasLowStream
                                        videoSize:(CGSize)videoSize;

- (BJLObservable)onPublish:(_LPMediaPublish *)publish;

- (BJLObservable)onRequestPublishDeny:(_LPMediaPublish *)publish;

#pragma mark - 音视频信息重新发布

- (void)requestMediaRePublishTriggerWithMediaServer:(_LPMediaServerModel *)mediaServer
                                               user:(BJLUser *)user
                                          sessionID:(NSString *)sessionID
                                          keepAlive:(BOOL)keepAlive
                                        skipRelease:(BOOL)skipRelease
                                          videoSize:(CGSize)videoSize;

- (BJLObservable)onRePublish:(_LPMediaRePublish *)republish;

- (BJLObservable)onRequestRePublishDeny:(_LPMediaRePublish *)republish;

#pragma mark - 取消音视频发布

- (void)requestMediaUnpublishWithSessionID:(NSString *)sessionID;

- (BJLObservable)onResponseUnpublish:(_LPResMediaUnpublish *)response;

#pragma mark - 音视频订阅 server 调度

- (void)requestMediaSubscribeWithLinkType:(BJLLinkType)linkType
                                loginUser:(BJLUser *)loginUser
                               targetUser:(_LPMediaUser *)targetUser
                               definition:(BJLLiveDefinitionKey)definitionkey
                             preferredCDN:(NSString *)preferredCDN
                                 isReplay:(BOOL)isReplay;

- (BJLObservable)onResponseSubscribe:(_LPResMediaSubscribe *)response;

#pragma mark - 辅助摄像头

- (BJLObservable)onPublishExtra:(_LPMediaPublish *)publish;

- (BJLObservable)onRequestPublishExtraDeny:(_LPMediaPublish *)publish;

- (BJLObservable)onRePublishExtra:(_LPMediaPublish *)republish;

#pragma mark - 邀请发言

// 老师邀请学生发言
- (void)requestSpeakInviteToUserID:(NSString *)userID invite:(BOOL)invite;

// 学生收到老师邀请发言
- (BJLObservable)onResponseSpeakInvite:(NSDictionary *)dict;

// 学生回应是否接受邀请
- (void)responseSpeakInvite:(BOOL)accept;

// 老师收到邀请发言结果
- (BJLObservable)onResponseSpeakInviteResult:(NSDictionary *)dict;

#pragma mark - 远程控制音视频开关

- (void)requestMediaRemoteControl:(_LPMediaRemoteControlModel *)control
                             user:(BJLUser *)user;

- (BJLObservable)onResponseRemoteControl:(_LPResMediaRemoteControl *)control;

- (BJLObservable)onRequestRemoteControlDeny:(_LPResMediaRemoteControl *)control;

// 家璐要求收到 onResponseRemoteControl: 后先发这个，然后再开关本地音视频
- (void)responseMediaRemoteControlWithUserID:(NSString *)userID
                                     audioOn:(BOOL)audioOn
                                     videoOn:(BOOL)videoOn;

#pragma mark - 学生申请发言

- (void)requestMediaSpeakApplyAskWithUser:(BJLUser *)user;

- (BJLObservable)onRequestSpeakApply:(_LPResMediaSpeakApply *)apply;

#pragma mark - 老师 接收/处理 发言申请

- (BJLObservable)onResponseSpeakApply:(_LPResMediaSpeakApply *)apply;
- (BJLObservable)onResponseSpeakApplyResult:(_LPResMediaSpeakApply *)apply;

// 允许/拒绝发言
- (void)requestMediaSpeakApplyAllow:(BOOL)allow user:(BJLUser *)user;

#pragma mark - 切换清晰度

- (void)requestVideoResolutionChangeWithSize:(CGSize)videoSize;

// 视频分辨率变化
- (BJLObservable)onResponseVideoResolutionChange:(_LPMediaResolution *)publish;

#pragma mark - 切换主屏

- (void)requestSwitchMainScreenToUserID:(NSString *)userID mediaID:(NSString *)mediaID loginUser:(BJLUser *)user;

- (BJLObservable)onResponseMainScreenSwitch:(NSDictionary *)dict;

#pragma mark- 视频镜像
- (void)updateVideoEncoderMirrorModeForAllPlayingUser:(NSUInteger)mode;
- (void)updateVideoEncoderMirrorMode:(NSUInteger)mode forUser:(BJLUser *)user;

- (BJLObservable)onReceiveUserVideoEncoderMirrorModeChange:(_LPResVideoMirrorMode *)change;

- (void)requestAllActiveUserVideoEncoderMirrorMode;

- (BJLObservable)onResponseAllActiveUserVideoEncoderMirrorModeHorizontalList:(NSArray<NSString *> *)horizontalUserNumberList verticalList:(NSArray<NSString *> *)verticalUserNumberList;
@end
