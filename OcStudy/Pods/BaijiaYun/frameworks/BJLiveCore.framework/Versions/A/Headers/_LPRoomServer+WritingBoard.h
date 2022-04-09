//
//  _LPRoomServer+WritingBoard.h
//  BJLiveCore
//
//  Created by 凡义 on 2019/3/22.
//  Copyright © 2019 BaijiaYun. All rights reserved.
//
#import "_LPBaseKit.h"

#import "_LPRoomServer.h"
#import "_LPResDocAdd.h"
#import "_LPResDocDel.h"
#import "_LPResDocUpdate.h"
#import "_LPResDocAll.h"
#import "_LPResPageChanged.h"

#import "BJLDocument.h"
#import "BJLWindowUpdateModel.h"

#import "_LPResAllShapes.h"
#import "_LPResAddShape.h"
#import "_LPResDelShape.h"
#import "_LPResUpdateShapes.h"
#import "_LPShape.h"
#import "_LPLaserPointerShape.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  小黑板相关信令服务
 */

@interface _LPRoomServer (WritingBoard)

- (void)regitsterSelectorsForResponsesForWritingBoard;

/**
 *  老师: 发布小黑板
 */
- (void)requestPublishWritingBoard:(NSDictionary *)dictionary fromUser:(BJLUser *)fromUser ;

/**
 *  返回res
 */
- (BJLObservable)onResponsePublishWritingBoard:(NSDictionary *)res;

/**
 *  学生: 提交小黑板
 */
- (void)requestSubmitWritingBoard:(NSString *)boardID fromUser:(BJLUser *)fromUser;

/**
 *  返回res
 */
- (BJLObservable)onResponseSubmitWritingBoard:(NSDictionary *)res;

/**
 *  拉取小黑板当前状态
 */
- (void)requestPullWritingBoardWithDoucumentID:(nullable NSString *)boardID;

- (void)requestPullWritingBoardWithDoucumentID:(nullable NSString *)boardID
                                   activeUsers:(nullable NSArray *)activeUsers
                                         count:(NSInteger)count
                                        cursor:(nullable NSString *)cursor;

/**
 *  返回res
 */
- (BJLObservable)onResponsePullWritingBoard:(NSDictionary *)res;

/**
 *  参与作答小黑板
 */
- (void)requestParticipateWritingBoardWithDoucumentID:(NSString *)boardID fromUser:(BJLUser *)fromUser;

/**
 *  返回res
 */
- (BJLObservable)onResponseParticipateWritingBoard:(NSDictionary *)res;

@end

NS_ASSUME_NONNULL_END
