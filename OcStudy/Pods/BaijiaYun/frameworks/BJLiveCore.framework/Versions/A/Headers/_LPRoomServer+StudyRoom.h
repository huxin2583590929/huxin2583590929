//
//  _LPRoomServer+StudyRoom.h
//  BJLiveCore
//
//  Created by Ney on 1/27/21.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"
#import "_LPResForIcStudyRoomActiveUserList.h"
#import "BJLStudyRoomTutorPair.h"
#import "BJLStudyRoomQuestion.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPRoomServer (StudyRoom)

- (void)regitsterSelectorsForResponsesForStudyRoom;

#pragma mark - 自习室
/** 请求自习室状态 */
- (void)requestStudyRoomStatus;

/** 收到自习室的状态数据 */
- (BJLObservable)onReceiveStudyRoomStatus:(NSDictionary *)res;

/** 请求变更自习室模式 */
- (void)requestChangeStudyRoomMode:(NSInteger)mode;

/** 收到变更自习室模式数据 */
- (BJLObservable)onReceiveChangeStudyRoomMode:(NSDictionary *)res;

/** 请求自习室自习时间列表数据 */
- (void)requestStudyRoomTimeRankList;

/** 收到自习室自习时间列表数据 */
- (BJLObservable)onReceiveStudyRoomTimeRankList:(_LPResForIcStudyRoomActiveUserList *)res;

/** 请求自习室台上用户列表数据 */
- (void)requestStudyRoomActiveUserList;

/** 收到自习室台上用户列表数据 */
- (BJLObservable)onReceiveStudyRoomActiveUserList:(_LPResForIcStudyRoomActiveUserList *)res;

/** 学生挂机/取消挂机 */
- (void)studyRoomHangUp:(BOOL)hangUp forUserNumber:(NSString *)userNumber;


#pragma mark - 场内辅导相关
/**
 发送辅导申请
 该信令会广播给教室内所有助教
*/
- (void)sendTutorRequestFrom:(NSString *)fromUserID to:(NSString *)toUserID;

/**
 收到辅导申请
 所有助教会收到申请
 */
- (BJLObservable)didReceiveTutorRequestFrom:(NSString *)fromUserID to:(NSString *)toUserID;

/**
 允许/拒绝辅导申请
 点对点发送
 */
- (void)replyTutorRequestFrom:(NSString *)fromUserID to:(NSString *)toUserID accept:(BOOL)accept;

/**
 收到允许/拒绝辅导申请的结果
 点对点接受
 */
- (BJLObservable)tutorRequestDidReplyFrom:(NSString *)fromUserID to:(NSString *)toUserID accepted:(BOOL)accepted;

/**
 开始辅导
 */
- (void)startTutorFrom:(NSString *)fromUserID to:(NSString *)toUserID;

/**
 辅导开始回调
 广播到所有端
 */
- (BJLObservable)tutorDidStartWithTutorPair:(BJLStudyRoomTutorPair *)tutorPair;

/**
 结束辅导
 */
- (void)endTutorWithTutorID:(NSString *)tutorID;

/**
 辅导结束回调
 广播到所有端
 */
- (BJLObservable)tutorDidEndWithTutorID:(NSString *)tutorID;

/**
 请求辅导配对数据
 */
- (void)requestTutorPairList;

/**
 收到辅导配对数据
 */
- (BJLObservable)onReceiveTutorPairList:(NSArray<BJLStudyRoomTutorPair *> *)tutorPairList;

#pragma mark - 场外辅导相关

/**
 学生&老师: 1v1辅导结束
 #param closeReason 结束原因
 */
- (BJLObservable)onTutorOutsideDidClosed:(NSInteger)closeReason;
@end

NS_ASSUME_NONNULL_END
