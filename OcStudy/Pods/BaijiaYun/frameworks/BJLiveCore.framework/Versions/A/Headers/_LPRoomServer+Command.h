//
//  _LPRoomServer+Command.h
//  BJLiveCore
//
//  Created by Randy on 16/5/18.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"

#import "_LPResCommandModel.h"
#import "_LPResCommandLinkInfo.h"
#import "_LPResCommandMediaControl.h"
#import "_LPResCommandLinkType.h"
#import "_LPResCommandUDPServer.h"
#import "BJLAnswerSheet.h"
#import "BJLStudyRoomQuestion.h"

@class _LPRunTimeInfo;
@class _LPLinkInfo;
@class _LPIpAddress;

@interface _LPRoomServer (Command)

- (void)regitsterSelectorsForResponsesForCommand;

/** 上传当前运行信息 */
- (BOOL)requestSendRunTimeInfo:(_LPRunTimeInfo *)info
                          from:(NSString *)fromId
                            to:(NSString *)toId;
/**
 *  收到此信号时，调用requestSendRunTimeInfo 上传信息
 *  _LPResCommandModel
 */
- (BJLObservable)onCommandRunTimeInfo:(_LPResCommandModel *)res;

/** 上传链路信息 */
- (BOOL)requestSendLinkInfo:(NSArray<_LPLinkInfo *> *)infos
                       from:(NSString *)fromId
                         to:(NSString *)toId;

/**
 *  收到此信号时，调用requestSendLinkInfo 上传信息
 *  _LPResCommandModel
 */
- (BJLObservable)onCommandLinkInfo:(_LPResCommandModel *)res;

/** 上传日志信息 */
- (BOOL)requestSendLocalLogInfo:(NSArray *)infos
                          from:(NSString *)fromId
                            to:(NSString *)toId;

/**
 *  收到此信号时，调用 requestSendLocalLogInfo 上传日志信息
 *  _LPResCommandModel
 */
- (BJLObservable)onCommandLocalLogInfo:(_LPResCommandModel *)res;

/** 上传UDP链路服务器改变的反馈 */
- (BOOL)requestSendLinkServerSwitchFrom:(NSString *)fromId
                                     to:(NSString *)toId;

/**
 *  切换上行链路 - UDP
 *
 *  _LPResCommandLinkInfo
 */
- (BJLObservable)onCommandSwitchUpLink:(_LPResCommandLinkInfo *)link;

/**
 *  切换下行链路 - UDP
 *
 *  _LPResCommandLinkInfo
 */
- (BJLObservable)onCommandSwitchDownLink:(_LPResCommandLinkInfo *)link;

/** 上传开关音视频的反馈 */
- (BOOL)requestSendMediaControlFrom:(NSString *)fromId
                                 to:(NSString *)toId;

/**
 *  开关用户 音视频
 *  audioOn, videoOn
 *
 *  _LPResCommandMediaControl
 */
- (BJLObservable)onCommandMediaControl:(_LPResCommandMediaControl *)media;

/** 上传上行链路类型改变的反馈 */
- (BOOL)requestSendUpLinkTypeChangeFrom:(NSString *)fromId
                                     to:(NSString *)toId;

/**
 *  修改用户上行链路类型
 *  BJLLinkType
 *
 *  _LPResCommandLinkType
 */
- (BJLObservable)onCommandChangeUpLinkType:(_LPResCommandLinkType *)media;

/** 上传下行链路类型改变的反馈 */
- (BOOL)requestSendDownLinkTypeChangeFrom:(NSString *)fromId
                                       to:(NSString *)toId;

/**
 *  修改用户下行链路类型
 *  BJLLinkType
 *
 *  _LPResCommandLinkType
 */
- (BJLObservable)onCommandChangeDownLinkType:(_LPResCommandLinkType *)media;


/**
  答题器：发送答案选项

 #param answerSheet 答题表
 #param fromUserID  发送方 ID
 #param toUserID    接收方 ID
 */
- (BOOL)requestSubmitAnswerSheet:(BJLAnswerSheet *)answerSheet from:(NSString *)fromUserID to:(NSString *)toUserID;

#pragma mark - 踢出教室

/** 踢出教室 */
- (BOOL)requestkickOutUserWithUserID:(NSString *)userID addToBlockList:(BOOL)addToBlockList;

/** 用户被请出教室 */
- (BJLObservable)onCommandKickOut:(_LPResCommandModel *)res;

#pragma mark - 刷新教室

- (BJLObservable)onCommandReloadRoom:(NSDictionary *)res;

#pragma mark - 结束外接设备

- (BOOL)requestStopCameraWithUserID:(NSString *)userID;

- (BJLObservable)onCommandStopCamera:(_LPResCommandModel *)res;

#pragma mark - 场外辅导

/** 学生: 收到老师的辅导通知 */
- (BJLObservable)onReceiveReplyForQuestion:(BJLStudyRoomQuestionReplyNotification *)questionReplyNotification;

@end
