//
//  _LPRoomServer+LPUser.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"

#import "_LPResRoomActiveUserList.h"
#import "_LPResRoomActiveUserAdd.h"
#import "_LPResRoomActiveUserRemove.h"
#import "_LPResRoomUserList.h"
#import "_LPResRoomUserIn.h"
#import "_LPResRoomUserOut.h"
#import "_LPResRoomUserCountChange.h"
#import "_LPResRoomCallService.h"
#import "_LPBlockedUser.h"

/**
 *  用户相关信令服务
 */

@interface _LPRoomServer (BJLUser)

- (void)regitsterSelectorsForResponsesForUser;

/** 请求当前活跃用户: 老师(没发言也在)、管理员(没发言也在)、发言用户 */
- (void)requestUserActives;
- (BJLObservable)onResponseUserActives:(_LPResRoomActiveUserList *)roomActiveUserList;

/** 请求教室内分组信息 */
- (void)requestGroupInfo;

/** 收到教室内分组信息*/
- (BJLObservable)onReceiveGroupInfo:(NSDictionary *)res;

/** 收到教室内分组更新信息*/
- (BJLObservable)onReceiveGroupUpdateInfo:(NSDictionary *)res;

/** 收到教室内分组成员更新信息*/
- (BJLObservable)onReceiveGroupMemberUpdateInfo:(NSDictionary *)res;

/**
 *  请求更多用户
 *  #param count 请求数量
 *  #param cursor 客户端记录最近一次 userMore 里最后一个 userId 当作 cursor、第一页传 @"0"、默认传 @"0"
 *  #param groupID 分组 ID
 */
// 使用服务端记录的 cursor
- (void)requestUserMoreWithCount:(NSInteger)count;
// 使用本地记录的 cursor
- (void)requestUserMoreWithCount:(NSInteger)count cursor:(NSString *)cursor;
// 使用本地记录的 cursor、groupID
- (void)requestUserMoreWithCount:(NSInteger)count
                          cursor:(NSString *)cursor
                         groupID:(NSInteger)groupID;

/**
 *  _LPResRoomUserList
 */
- (BJLObservable)onResponseUserMoreModel:(_LPResRoomUserList *)userList;

/**
 *  _LPResRoomUserIn
 */
- (BJLObservable)onResponseUserInModel:(_LPResRoomUserIn *)userIn;
/**
 *  _LPResRoomUserOut
 */
- (BJLObservable)onResponseUserOutModel:(_LPResRoomUserOut *)userOut;
/**
 *  _LPResRoomUserCountChange
 *
 *  隔几秒返回一次，如果count没变化也会返回
 */
- (BJLObservable)onResponseUserCountChangeModel:(_LPResRoomUserCountChange *)userCount;

/**
 *  紧急呼叫
 */
- (void)requestUserCallServiceWithNumber:(NSString *)number userNumber:(NSString *)userNumber;
/**
 *  _LPResRoomCallService
 */
- (BJLObservable)onResponseCallService:(_LPResRoomCallService *)callservice;
- (id<BJLObservation>)onResponseCallServiceForSwift:(BJLControlObserving (^)(_LPResRoomCallService *callservice))observer;

/**
 *  切换主讲人
 *  NSDictionary *dict: {
 *      presenter_id: {string}
 *  }
 */
- (BJLObservable)onPresenterChange:(NSDictionary *)dict;

/**
 *  切换主讲人
 */
- (void)requestPresenterChangeWithUserID:(NSString *)userID;

/**
 *  收到用户被踢出教室通知
 */
- (BJLObservable)onResponseBlockedUser:(_LPBlockedUser *)blockedUser;

/**
 *  请求黑名单列表
 */
- (void)requestBlockedUserList;

/**
 *  返回黑名单列表
 */
- (BJLObservable)onResponseBlockedUserList:(NSDictionary *)dict;

/**
 *  解除用户的黑名单
 */
- (void)requestFreeBlockedUserWithUserNumber:(NSString *)userNumber;

/**
 *  用户的黑名单被解除
 */
- (BJLObservable)onResponseBlockedUserFreed:(NSDictionary *)dict;

/**
 *  解除黑名单所有人
 */
- (void)requestFreeAllBlockedUser;

/**
 *  黑名单所有人被解除
 */
- (BJLObservable)onResponseBlockedUserAllFreed;

#pragma mark - user update

/**
*   更新用户的音视频的状态，状态的有效值为非负数，如果单独更新某一个状态，不更新的的状态设置成负数
*/
- (void)requestUpdateUserWithNumber:(NSString *)userNumber audioState:(NSInteger)audioState videoState:(NSInteger)videoState;

/**
 *  更新用户是否支持指定的 user number 被替换摄像头
 */
- (void)requestUpdateUserWithNumber:(NSString *)userNumber numberReplaceMe:(NSString *)numberReplaceMe;

/**
*  用户的音视频的状态被更新，负数为无效状态，认为没有更新
*/
- (BJLObservable)onResponseUserUpdateWithNumber:(NSString *)userNumber audioState:(NSInteger)audioState videoState:(NSInteger)videoState;

/**
 *  用户关闭摄像头时的背景图片变化，图片可为空，即恢复成默认
 */
- (BJLObservable)onResponseUserUpdateWithNumber:(NSString *)userNumber cameraCover:(NSString *)cameraCover;

/**
 *  用户是否支持指定的 user number 被替换摄像头状态更新，replacedNumber 可为空
 */
- (BJLObservable)onResponseUserUpdateWithNumber:(NSString *)userNumber numberReplaceMe:(NSString *)numberReplaceMe;

#pragma mark - interactive class 专业版小班课 API

/**
 专业版小班课 - 用户上台请求

 #param user 目标用户
 */
- (void)requestAddActiveUser:(BJLUser *)user;

/**
 专业版小班课 - 用户上台通知

 #param roomActiveUserAdd 上台信息
 */
- (BJLObservable)onResponseActiveUserAdd:(_LPResRoomActiveUserAdd *)roomActiveUserAdd;

/**
 专业版小班课 - 用户上台请求被拒绝的通知

 #param roomActiveUserAdd 上台信息
 */
- (BJLObservable)onResponseActiveUserAddDeny:(_LPResRoomActiveUserAdd *)roomActiveUserAdd;


/**
 专业版小班课 - 用户下台请求

 #param user 目标用户
 */
- (void)requestRemoveActiveUser:(BJLUser *)user;


/**
 专业版小班课 - 用户下台通知

 #param roomActiveUserRemove 下台信息
 */
- (BJLObservable)onResponseActiveUserRemove:(_LPResRoomActiveUserRemove *)roomActiveUserRemove;

@end
