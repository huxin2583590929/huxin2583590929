//
//  _LPRoomServer+Homework.h
//  BJLiveCore
//
//  Created by 凡义 on 2020/8/19.
//  Copyright © 2020 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"
#import "BJLHomework.h"
#import "_LPResHomeworkAll.h"
#import "_LPResHomeworkDel.h"
#import "_LPResHomeworkAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPRoomServer (Homework)

- (void)regitsterSelectorsForResponsesForHomework;

// 请求：添加作业
- (void)requestAddHomework:(BJLHomework *)Homework withUserInfo:(NSDictionary *)userDic;

// 回调：添加作业
- (BJLObservable)onResponseHomeworkAdd:(_LPResHomeworkAdd *)homework;

// 请求：删除作业
- (void)requestHomeworkDelete:(NSString *)homeworkID userRole:(NSInteger)userRole;

// 回调：删除作业
- (BJLObservable)onResponseHomeworkDel:(_LPResHomeworkDel *)model;

// 请求：获取所有作业
- (void)requestHomeworkAllWithUserInfo:(NSDictionary *)userDic
                               keyword:(nullable NSString *)keyword
                                cursor:(nullable NSDictionary *)cursor
                                 count:(NSInteger)count;

// 回调：所有作业信息
- (BJLObservable)onResponseHomeworkAll:(_LPResHomeworkAll *)homeworks;

// 回调：后台关联作业有更新
- (BJLObservable)onResponseHomeworkSyncUpdate:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
