//
//  _LPLocalLog.h
//  BJLiveCore
//
//  Created by daixijia on 2018/3/15.
//  Copyright © 2018年 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _LPLocalLog : NSObject

/** 获得日志 */
@property (nonatomic, strong, readonly) NSArray *logs;

/** 最后的一条聊天消息 */
@property (nonatomic) NSDictionary *lastChatMessage;

/** 使用单例 */
+ (instancetype)defaultLogManager;

/** 在需要记录的运行信息处调用，会自动补上收到的运行时信息时的时间戳 */
- (void)addLogMessage:(NSString *)message;

/** 在发送心跳的时候调用，记录最近发送的十条心跳，会自动补上发送心跳时的时间戳 */
- (void)addHeartBeatMessage:(NSString *)message;

/** 获取教室信令的最近的一些 log，调用此方法会清空 log */
- (NSArray *)roomLogsWithCount:(NSInteger)count;

@end
