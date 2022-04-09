//
//  _LPRoomServer+LPBrush.h
//  BJLiveCore
//
//  Created by Randy on 16/4/28.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPBaseKit.h"

#import <BJLiveBase/_LPResAllShapes.h>
#import <BJLiveBase/_LPResAddShape.h>
#import <BJLiveBase/_LPResAppendShape.h>
#import <BJLiveBase/_LPResDelShape.h>
#import <BJLiveBase/_LPResUpdateShapes.h>
#import <BJLiveBase/_LPShape.h>
#import <BJLiveBase/_LPLaserPointerShape.h>

NS_ASSUME_NONNULL_BEGIN

@interface _LPRoomServer (_LPBrush)

- (void)regitsterSelectorsForResponsesForBrush;

/**
 获取文档指定页的所有画笔

 #param docId 目标文档 ID
 #param pageIndex 目标页码
 #param isWritingBoard 是否为小黑板
 #param userNumber    userNumber
 #return 请求是否成功发送
 */
- (BOOL)requestAllShapeWithDocId:(NSString *)docId
                            page:(NSUInteger)pageIndex
                  isWritingBoard:(BOOL)isWritingBoard
                      userNumber:(nullable NSString *)userNumber;
/**
 获取指定页所有画笔成功的回调

 #param res 所有画笔信息
 */
- (BJLObservable)onResponseAllShapes:(_LPResAllShapes *)res;

/**
 添加画笔

 #param shape 画笔实例
 #param docId 目标文档 ID
 #param pageIndex 目标页码
 #param isWritingBoard 是否为小黑板
 #param userNumber    userNumber
 #return 请求是否成功发送
 */
- (BOOL)requestAddShape:(_LPShape *)shape
                  docId:(NSString *)docId
                   page:(NSUInteger)pageIndex
         isWritingBoard:(BOOL)isWritingBoard
             userNumber:(nullable NSString *)userNumber;

/**
 自己发送标注触发 —— 避免从服务器走一遍回来再显示导致不能实时绘制

 #param res 画笔信息
 */
- (BJLObservable)onMyAddShape:(_LPResAddShape *)res;

/**
 添加画笔成功的回调
 
 #param res 画笔信息
 */
- (BJLObservable)onResponseAddShape:(_LPResAddShape *)res;

/**
 增量添加画笔

 #param shape 画笔实例
 #param docId 目标文档 ID
 #param pageIndex 目标页码
 #param isWritingBoard 是否为小黑板
 #param userNumber    userNumber
 #return 请求是否成功发送
 */
- (BOOL)requestAppendShape:(_LPShape *)shape
                     docId:(NSString *)docId
                      page:(NSUInteger)pageIndex
            isWritingBoard:(BOOL)isWritingBoard
                userNumber:(nullable NSString *)userNumber;

/**
 增量添加画笔成功回调

 #param res 画笔信息
 */
- (BJLObservable)onResponseAppendShape:(_LPResAppendShape *)res;

/**
 更新激光笔

 #param laserPointShape 激光笔实例
 #param documentID 目标文档 ID
 #param pageIndex 目标页码
 #return 请求是否成功发送
 */
- (BOOL)requestUpdateLaserPoint:(_LPLaserPointerShape *)laserPointShape
                     documentID:(nonnull NSString *)documentID
                      pageIndex:(NSUInteger)pageIndex;

/**
 激光笔更新回调

 #param res 激光笔信息
 */
- (BJLObservable)onResponseLaserPointer:(_LPResAddShape *)res;

/**
 删除画笔

 #param shapeId 画笔 ID
 #param docId 画笔所在文档 ID
 #param pageIndex 画笔所在页码
 #param isWritingBoard 是否为小黑板
 #param userNumber    userNumber
 #return 请求是否成功发送
 */
- (BOOL)requestDelShapeWithId:(NSString *)shapeId
                        docId:(NSString *)docId
                         page:(NSUInteger)pageIndex
               isWritingBoard:(BOOL)isWritingBoard
                   userNumber:(nullable NSString *)userNumber;

/**
 删除画笔回调

 #param res 画笔信息
 */
- (BJLObservable)onResponseDelShape:(_LPResDelShape *)res;

/**
 更新画笔，支持批量更新
 #param list 画笔数组
 #param docId 画笔所在文档 ID
 #param pageIndex 画笔所在页码
 #param isWritingBoard 是否为小黑板
 #param userNumber    userNumber
 #return 请求是否发送成功
 */
- (BOOL)requestUpdateShapes:(NSArray<_LPShape *> *)list
                      docId:(NSString *)docId
                       page:(NSUInteger)pageIndex
             isWritingBoard:(BOOL)isWritingBoard
                 userNumber:(nullable NSString *)userNumber;

/**
 画笔批量更新回调

 #param res 画笔数组
 */
- (BJLObservable)onResponseUpdateShapes:(_LPResUpdateShapes *)res;

@end

NS_ASSUME_NONNULL_END
