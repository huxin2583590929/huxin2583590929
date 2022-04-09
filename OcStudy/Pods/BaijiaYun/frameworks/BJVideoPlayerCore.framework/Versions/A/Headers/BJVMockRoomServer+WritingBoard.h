//
//  BJVMockRoomServer+WritingBoard.h
//  BJVideoPlayerCore
//
//  Created by 辛亚鹏 on 2021/7/5.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import "_BJVMockRoomServer.h"

#import "_VPResDocAdd.h"
#import "_VPResDocDel.h"
#import "_VPResDocUpdate.h"
#import "_VPResDocAll.h"
#import "_VPResPageChanged.h"

#import "BJVWindowUpdateModel.h"

#import <BJLiveBase/BJLDocument.h>
#import <BJLiveBase/_LPResAllShapes.h>
#import <BJLiveBase/_LPResAddShape.h>
#import <BJLiveBase/_LPResDelShape.h>
#import <BJLiveBase/_LPResUpdateShapes.h>
#import <BJLiveBase/_LPShape.h>
#import <BJLiveBase/_LPLaserPointerShape.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  小黑板相关信令服务
 */
@interface BJVMockRoomServer (WritingBoard)

- (void)regitsterSelectorsForResponsesForWritingBoard;

/**
 *  老师: 发布小黑板
 */
//- (void)requestPublishWritingBoard:(NSDictionary *)dictionary fromUser:(BJVUser *)fromUser ;

/**
 *  返回res
 */
- (BJLObservable)onResponsePublishWritingBoard:(NSDictionary *)res;

/**
 *  学生: 提交小黑板
 */
//- (void)requestSubmitWritingBoard:(NSString *)boardID fromUser:(BJVUser *)fromUser;

/**
 *  返回res
 */
- (BJLObservable)onResponseSubmitWritingBoard:(NSDictionary *)res;

/**
 *  拉取小黑板当前状态
 */
//- (void)requestPullWritingBoardWithDoucumentID:(nullable NSString *)boardID;
//
//- (void)requestPullWritingBoardWithDoucumentID:(nullable NSString *)boardID
//                                   activeUsers:(nullable NSArray *)activeUsers
//                                         count:(NSInteger)count
//                                        cursor:(nullable NSString *)cursor;

/**
 *  返回res
 */
- (BJLObservable)onResponsePullWritingBoard:(NSDictionary *)res;

/**
 *  参与作答小黑板
 */
//- (void)requestParticipateWritingBoardWithDoucumentID:(NSString *)boardID fromUser:(BJVUser *)fromUser;

/**
 *  返回res
 */
- (BJLObservable)onResponseParticipateWritingBoard:(NSDictionary *)res;


@end

NS_ASSUME_NONNULL_END
