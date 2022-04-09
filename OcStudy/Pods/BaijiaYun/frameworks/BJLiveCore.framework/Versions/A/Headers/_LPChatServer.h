//
//  _LPChatServer.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/25.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPWSServerBase.h"
#import "_LPChatServerLogin.h"

@class BJLUser;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Chat Server
 */
@interface _LPChatServer : _LPWSServerBase

// 预先设置登录信息、在连接成功后发送
- (void)loginWithRoomId:(NSString *)roomId
                   user:(BJLUser *)user
          partnerConfig:(NSDictionary *)partnerConfig;

/**
 *  登录返回
 */
- (BJLObservable)onMessageChatLogin:(_LPChatServerLogin *)login;

/**
 *  发送消息
 *  #param content  文字消息
 *  #param data     富文本消息，支持表情、图片等，JSON 格式
 *  #param channel  消息频道
 *  #param hidden   隐藏字段，附带隐藏信息，用于追踪问题
 *  #param fromUser 发送人
 *  #param toUser   接收人
 */
- (void)requestMessageSend:(nullable NSString *)content
                      data:(nullable NSDictionary *)data
                   channel:(nullable NSString *)channel
                    hidden:(nullable NSDictionary *)hidden
                      from:(BJLUser *)fromUser
                        to:(nullable BJLUser *)toUser;
/**
 *  接收消息
 *      BJLMessage
 */
- (BJLObservable)onMessageReceive:(BJLMessage *)message;


/**
 *  接收私聊消息
 *      BJLMessage
 */
- (BJLObservable)onWhisperMessageReceive:(BJLMessage *)message;

/**
*  撤回消息
*/
- (void)requestMessageRevoke:(NSString *)messageID
                      roomID:(NSString *)roomID
                    fromUser:(BJLUser *)fromUser
                   loginUser:(BJLUser *)loginUser;

/**
*  消息撤回成功
*/
- (BJLObservable)onMessageRevokeSuccess:(NSDictionary *)dictionary;

/**
*   有消息被撤回（非当前用户撤回）
*/
- (BJLObservable)onMessageRevoke:(NSDictionary *)dictionary;

/**
 *  发送需要翻译的消息
 #param content     消息内容
 #param messageUUID 消息唯一ID
 #param classID     消息所在教室id
 #param userID      当前登录用户id
 */
- (void)requestTranslateMessageSend:(NSString *)content
                        messageUUID:(NSString *)messageUUID
                            classID:(NSString *)classID
                             userID:(NSString *)userID
                      translateType:(BJLMessageTranslateType)translateType;

/** 接收英汉互译消息返回
 #param translation 消息翻译的结果
 #param messageUUID 消息唯一ID
 */
- (BJLObservable)onReceiveMessageTranslation:(NSString *)translation
                                  messageUUID:(nullable NSString *)messageUUID;

/** 禁言单个用户 */
- (void)requestForbidUser:(BJLUser *)user
                  classID:(NSString *)classID
                 duration:(NSTimeInterval)duration
                     from:(BJLUser *)from;

/** 助教禁言自己的分组,大班老师助教禁言整个教室 */
- (void)requestForbidGroupWithDuration:(NSTimeInterval)duration
                               classID:(NSString *)classID
                                  from:(BJLUser *)from;

@end

NS_ASSUME_NONNULL_END
