//
//  _LPLogStat.h
//  BJLiveCore
//
//  Created by Randy on 16/5/25.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "_BJLContext.h"
#import "_LPLogConstants.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BJLQSLogFailedEventType) {
    BJLQSLogFailedEventTypeWWWServer,       //连接www服务器失败
    BJLQSLogFailedEventTypeMasterServer,    //连接MS失败
    BJLQSLogFailedEventTypeRoomServer,      //连接MRS失败
    BJLQSLogFailedEventTypeDownMediaServer, //接音视频服务器失败
    BJLQSLogFailedEventTypePull,            //拉流失败
    BJLQSLogFailedEventTypePublish          //推流失败
};

FOUNDATION_EXPORT NSString *const _LP_LOG_APP_TYPE;

@interface _LPLogStat : NSObject

+ (nullable BJLContext *)context;
+ (void)setContextGetter:(BJLContext *(^)(void))getter;

/**
 上报事件

 #param eventParams 上报事件参数
 #param completion  上报请求完成回调
 #return            上报请求的 task
 */
+ (NSURLSessionTask *)reportEventWithParams:(NSDictionary *)eventParams completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task,
                                                                                                      NSDictionary *params,
                                                                                                      NSError * _Nullable error))completion;

#pragma mark - 新版上报

+ (instancetype)sharedInstance;

/**
 上报事件到qs.baijiayun.com/heart
 
 #param eventParams 上报事件参数
 #param completion  上报请求完成回调
 #return            上报请求的 task
 */
- (NSURLSessionTask *)reportQSEventWithParams:(NSDictionary *)eventParams completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task,
                                                                                                      NSDictionary *params,
                                                                                                      NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
