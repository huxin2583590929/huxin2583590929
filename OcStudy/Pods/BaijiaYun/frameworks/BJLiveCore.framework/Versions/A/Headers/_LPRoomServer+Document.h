//
//  _LPRoomServer+Document.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"
#import "_LPResDocAdd.h"
#import "_LPResDocDel.h"
#import "_LPResDocUpdate.h"
#import "_LPResDocAll.h"
#import "_LPResPageChanged.h"
#import "_LPResPageAdd.h"
#import "_LPResPageDel.h"

#import "BJLDocument.h"
#import "BJLWindowUpdateModel.h"

/**
 *  文档相关信令服务
 */
@interface _LPRoomServer (Document)

- (NSDictionary *)replaceWhiteboardURLStringWhenReceiveDocAllResponse:(NSDictionary *)response;

- (void)regitsterSelectorsForResponsesForDocument;

// 请求：添加文档
- (void)requestAddDocument:(BJLDocument *)document;

// 回调：添加文档
- (BJLObservable)onResponseDocAdd:(_LPResDocAdd *)model;

// 请求：更新文档显示信息
- (void)requestDocUpdateWithID:(NSString *)documentID displayInfo:(BJLDocumentDisplayInfo *)displayInfo;

// 回调：更新文档
- (BJLObservable)onResponseDocUpdate:(_LPResDocUpdate *)model;

// 请求：删除文档
- (void)requestDocDelete:(NSString *)docId;

// 回调：删除文档
- (BJLObservable)onResponseDocDel:(_LPResDocDel *)model;

// 请求：获取所有文档
- (void)requestDocAll;

// 回调：所有文档信息
- (BJLObservable)onResponseDocAll:(_LPResDocAll *)model;

/**
 *  文档翻页
 *
 *  #param docId
 *  #param page  页码
 *  #param step  动画步数
 */
- (void)requestDocPageChange:(NSString *)docId
                  pageNumber:(NSUInteger)page
                  stepNumber:(NSUInteger)step;
/**
 *  文档翻页，目前仅用于白板翻页
 *
 *  #param docId
 *  #param pageId  页码
 *  #param step  动画步数
 */
- (void)requestDocPageChange:(NSString *)docId
                  pageId:(NSUInteger)pageId
                  stepNumber:(NSUInteger)step;

// 回调：文档翻页
- (BJLObservable)onResponseDocPageChanged:(_LPResPageChanged *)model;

// 请求：添加文档页（目前仅用于白板）
- (void)requestDocPageAdd:(NSString *)docId;

// 回调：添加文档页（目前仅用于白板）
- (BJLObservable)onResponseDocPageAdd:(_LPResPageAdd *)model;

// 请求：删除文档页（目前仅用于白板）
- (void)requestDocPageDelete:(NSString *)docId pageIndex:(NSInteger)pageIndex;

// 回调：删除文档页（目前仅用于白板）
- (BJLObservable)onResponseDocPageDel:(_LPResPageDel *)model;

// 请求：网页形式的课件快照以及缓存数据
- (void)requestH5SnapshotAndRecords:(NSString *)docId;

// 回调：网页形式的课件快照以及缓存数据
- (BJLObservable)onResponseH5SnapshotAndRecords:(NSDictionary *)model;

// 网页形式的课件增量更新数据
- (BJLObservable)onResponseH5AddRecords:(NSDictionary *)model;

// 网页形式的课件快照更新数据
- (BJLObservable)onResponseH5SnapshotUpdate:(NSDictionary *)model;

@end
