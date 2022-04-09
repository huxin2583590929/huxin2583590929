//
//  LPWSServerBase.h
//  Pods
//
//  Created by 杨磊 on 16/3/24.
//
//

#import <Foundation/Foundation.h>
#import <BJLiveBase/BJLPSWebSocket.h>

typedef NS_ENUM(NSInteger, BJWSConnectState) {
    BJ_WS_STATE_Offline,
    BJ_WS_STATE_Connecting,
    BJ_WS_STATE_Connected
};

typedef NS_ENUM(NSInteger, BJWSDisconnectCode) {
    BJ_WS_DisconnectCode_failedToConnect, // 建立连接失败
    BJ_WS_DisconnectCode_disconnected, // 连接被动断开
    BJ_WS_DisconnectCode_disconnect // 主动断开连接
};

typedef NS_ENUM(NSInteger, BJ_WS_RequestType) {
    BJ_WS_RequestType_Text,
    BJ_WS_RequestType_Binary
};
typedef NS_ENUM(NSInteger, BJ_WS_ResponseType) {
    BJ_WS_ResponseType_Auto, // will be String or Data
    BJ_WS_ResponseType_String,
    BJ_WS_ResponseType_Dictionary,
    BJ_WS_ResponseType_Data
};

/**
 包装 Socket 类

 1、请求队列， 连接成功前发出的请求会缓存下来。待连接成功后自动重新发送. 防止中间断开重连时消息丢失
 
 供外界调用或继承的类。
 */
@interface _BJWebSocketBase : NSObject

@property (nonatomic, readonly) BJWSConnectState state;
@property (nonatomic, readonly) BJLPSWebSocketStatusCode statusCode;
@property (nonatomic, readonly) NSString *reason;
@property (nonatomic, readonly/* , nonnull */) NSMutableArray *requestQueue;

@property (nonatomic) BJ_WS_RequestType requestType;
@property (nonatomic) BJ_WS_ResponseType responseType;
@property (nonatomic, readonly) BOOL autoReconnect; // default: NO

- (instancetype)init;
- (instancetype)initWithURLString:(NSString *)urlString NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, copy) NSString *userAgentSuffix;

// timeoutInterval < 0.0: use NSURLRequest.timeoutInterval - 60
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

// 发起连接时调用
- (NSString *)getCurrentURLString;

/**
 *  发起连接
 */
- (void)connect; // autoReconnect: NO
- (void)connect:(BOOL)autoReconnect;

/**
 *  断开连接
 */
- (void)disconnect; // reset autoReconnect

/**
 * 发起重连
 */
- (void)reconnect;

/**
 *  发送请求, 未连接状态下不会执行发送。 调用前需要判断状态
 *
 *  #param request
 *  #return YES 已发出。 NO 未发出
 */
- (BOOL)sendRequest:(id)request;
- (BOOL)sendRequest:(id)request requestType:(BJ_WS_RequestType)requestType;

/**
 *  收到响应
 *
 *  #param response
 */
// 每个消息只会回调一个方法，调用哪一个取决于 self.responseType，在子线程调用
- (void)onResponseWithString:(NSString *)response;
- (void)onResponseWithDictionary:(NSDictionary *)response;
- (void)onResponseWithData:(NSData *)response;

/**
 *  连接状态发生改变
 *
 *  #param state 状态值
 */
- (void)onStateChanged:(BJWSConnectState)state;

/**
 *  reconnect 执行第一时间调用，autoReconnect 为 YES 时有效
 */
- (void)onWillReconnect;

/**
 *  建立连接失败、连接被断开、主动断开连接都会调用，通过 code 区分
 */
- (void)onWillDisconnectWithCode:(BJWSDisconnectCode)code;
- (void)onDisconnectWithCode:(BJWSDisconnectCode)code;

@end
