//
//  _LPRoomServer.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/25.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#if __has_feature(modules) && BJL_USE_SEMANTIC_IMPORT
@import BJLiveBase;
#else
#import <BJLiveBase/BJLiveBase.h>
#endif

#import "_LPWSServerBase.h"

#import "_LPRoomLoginModel.h"
#import "_LPBroadcastOptions.h"
#import "_LPResBroadcastReceive.h"
#import "_LPRoomLoginConflict.h"
#import "_LPRoomInfo.h"

#import "BJLFeatureConfig.h"
#import "BJLUser.h"

FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_BROADCAST_SEND;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_BROADCAST_RECEIVE;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_BROADCAST_CACHE_REQ;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_BROADCAST_CACHE_RES;

FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_ALL;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TEACHER_UPLINK;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_CLOUD_RECORD;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_CLASS_TIME;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TEACHER_ABROAD;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_FORBID_ALL;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_FORBID_RAISE_HAND_CHANGE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_ANSWER_START;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_ANSWER_END;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_PLAY_MEDIA;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_SHARE_DESKTOP;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_INTERACTION;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_DOC_VIEW_UPDATE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_WEB_DOC_VIEW_UPDATE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_PLAYER_VIEW_UPDATE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_ROOM_LAYOUT_UPDATE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_SNIPPET_VIEW_UPDATE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_GRANTED_PAINT_COLOR;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_WEB_PAGE_INFO;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_PRESENTER_UPLINK_LOSS_RATE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_IS_STUDENT_CAN_CHANGE_PPT;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_ADMIN_AUTH;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_DISABLE_OTHER_STUDENT_VIDEO;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_PLAY_CLOUD_VIDEO;

FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TOOL_COMPONENT_DESTORY;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TOOL_COMPONENT_DESTORY_TOOL_ANSWER;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TOOL_COMPONENT_DESTORY_TOOL_ANSWER_RACER;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TOOL_COMPONENT_DESTORY_TOOL_TIMER;

FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TOOL_TIMER_CACHE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TOOL_TIMER_START;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_TOOL_TIMER_REVOKE;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_INTERACTION_RED_PACKET;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_INTERACTION_RED_PACKET_FINISH;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_INTERACTION_RED_PACKET_RANKING_LIST;


FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_QUIZ_CACHE_LIST;

FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_ROOM_PPT_VIDEO_SWITCH;

FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_START_TRIGGER;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_START;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_END_TRIGGER;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_END;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_SOLUTION_TRIGGER;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_SOLUTION;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_REQ;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_RES;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_SUBMIT;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_SUBMIT_TOSUPER;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_PARENT_ROOM_QUIZ_REQ;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_QUIZ_PARENT_ROOM_QUIZ_RES;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_BJY_TIMER_COUNTDOWN;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_CLASS_START_TIME;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_ALLOW_UPLOAD_HOMEWORK;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_H5_PPT_AUTH_UPDATE;

FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_CUSTOMCAST_SEND;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_CUSTOMCAST_RECEIVE;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_CUSTOMCAST_CACHE_REQ;
FOUNDATION_EXPORT NSString *const _LP_ROOM_SERVER_CUSTOMCAST_CACHE_RES;

FOUNDATION_EXPORT NSString *const _LP_CUSTOMCAST_KEY_WEB_DOC;

FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_LIVE_USER_IN;
FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_SALE_GOODS_UPDATE;

FOUNDATION_EXPORT NSString *const _LP_BROADCAST_KEY_MAIN_SCREEN_NOTICE;

/**
 *  Room Server
 */
@interface _LPRoomServer : _LPWSServerBase

/**
 *  请求公共参数
 */
@property (nonatomic, copy) NSDictionary *commonParams;

@property (nonatomic, readonly) BOOL isOnline;
@property (nonatomic) NSInteger delayTimeInterval;
- (void)requestClenShapeAddAndAppendSignalAfterLatestPageChange;
- (NSInteger)broadcastMaxCount;
- (NSInteger)catchedBroadcastMaxCount;

@property (nonatomic) BOOL needReplaceWhiteboardURLString;
@property (nonatomic) BJLWhiteboard *whiteboard;

@property (nonatomic) NSDictionary *studentAuthority;

// 预先设置登录信息、在连接成功后发送
- (void)loginWithUser:(BJLUser *)user
            className:(NSString *)className
           speakState:(_LPSpeakState)speakState
                token:(NSString *)token
            supported:(NSDictionary *)supported
        partnerConfig:(NSDictionary *)partnerConfig
             roomInfo:(_LPRoomInfo *)roomInfo
        featureConfig:(BJLFeatureConfig *)featureConfig
     validateConflict:(BOOL)validateConflict;

/**
 *  请求服务器缓存的广播
 *
 *  #param key 缓存的广播 key
 */
- (void)requestBroadcastCache:(NSString *)key;

/**
 *  发送广播
 *
 *  #param key     广播key
 *  #param value   广播值
 *  #param options 选项
 */
- (void)requestBroadcastSendKey:(NSString *)key
                          value:(id)value
                        options:(_LPBroadcastOptions *)options;


/**
 *  发送广播
 *
 *  #param key     广播key
 *  #param value   广播值
 *  #param options 选项
 *  #param notifyServerForward 通知服务器之间转发，一般不使用
 *  #param parentRoomID 教室的父级教室，没有则为 nil
 */
- (void)requestBroadcastSendKey:(NSString *)key
                          value:(id)value
                        options:(_LPBroadcastOptions *)options
            notifyServerForward:(BOOL)notifyServerForward
                   parentRoomID:(NSString *)parentRoomID;


/**
*  请求服务器缓存的定制广播
*
*  #param key 缓存的广播 key
*/
- (void)requestCustomBroadcastCache:(NSString *)key;

/**
*  发送定制广播
*
*  #param key     广播key
*  #param value   广播值
*  #param options 选项
*/
- (void)requestCustomBroadcastSendKey:(NSString *)key
                          value:(id)value
                              options:(_LPBroadcastOptions *)options;

/**
 *  @see - (BOOL)sendRequest:(id)request;
 */
- (BJLObservable)onResponseWithSignal:(NSDictionary *)signal;

/**
 *  登录成功需要判断 res && res.code == _LPErrorCode_SUC
 */
- (BJLObservable)onResponseLoginModel:(_LPRoomLoginModel *)loginModel;

/**
 *  _LPRoomLoginConflict
 */
- (BJLObservable)onResponseLoginConflict:(_LPRoomLoginConflict *)model;

/**
 *  _LPResBroadcastReceive
 */
- (BJLObservable)onResponseBroadcastReceive:(_LPResBroadcastReceive *)model;

/**
 *  _LPResBroadcastReceive
 */
- (BJLObservable)onResponseBroadcastCache:(_LPResBroadcastReceive *)model;

/**
 *  _LPResCustomcastReceive
 */
- (BJLObservable)onResponseCustomBroadcastReceive:(_LPResBroadcastReceive *)model;

/**
 *  _LPResCustomcastReceive
 */
- (BJLObservable)onResponseCustomBroadcastCache:(_LPResBroadcastReceive *)model;

/**
 *  切换大小班
 */
- (BJLObservable)onResponseSwitchClass:(NSDictionary *)dict;

#pragma mark -

/**
*  检查部分功能是否支持
*/
- (void)requestCheckSupport;

- (BJLObservable)onResponseCheckSupport:(NSDictionary *)dict;

#pragma mark - internal

- (BJLObservable)didSendSignal:(NSDictionary *)dictionary;

@end
