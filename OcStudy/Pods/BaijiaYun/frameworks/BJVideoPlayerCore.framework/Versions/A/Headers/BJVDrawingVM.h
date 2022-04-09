//
//  BJVDrawingVM.h
//  BJVideoPlayerCore
//
//  Created by 辛亚鹏 on 2021/7/5.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import "BJVBaseVM.h"
#import <BJLiveBase/BJLSlideshowUI.h>

NS_ASSUME_NONNULL_BEGIN

/** ### 画笔管理 */
@interface BJVDrawingVM : BJVBaseVM

/** 画笔操作模式 */
@property (nonatomic, readonly) BJLBrushOperateMode brushOperateMode;

/** 画笔类型 */
@property (nonatomic) BJLDrawingShapeType drawingShapeType;

/** 画笔边框颜色 */
@property (nonatomic, nonnull) NSString *strokeColor;

/** 画笔边框颜色透明度，取值范围 0~1 */
@property (nonatomic) CGFloat strokeAlpha;

/** 画笔填充颜色 */
@property (nonatomic, nullable) NSString *fillColor;

/** 画笔填充颜色透明度，取值范围 0~1, fillColor 不为空时有效 */
@property (nonatomic) CGFloat fillAlpha;

/** doodle 画笔线宽 */
@property (nonatomic) CGFloat doodleStrokeWidth;

/** 图形画笔边框线宽 */
@property (nonatomic) CGFloat shapeStrokeWidth;

/** 文字画笔字体大小 */
@property (nonatomic) CGFloat textFontSize;

/** 文字画笔是否加粗 */
@property (nonatomic) BOOL textBold;

/** 文字画笔是否为斜体 */
@property (nonatomic) BOOL textItalic;

/** 画笔开关状态，参考 `drawingGranted`、`updateDrawingEnabled:` */
@property (nonatomic, readonly) BOOL drawingEnabled;

/** doodle 画笔是否虚线 */
@property (nonatomic) BOOL isDottedLine;

/** 选中画笔时是否显示归属信息 */
@property (nonatomic) BOOL showBrushOwnerNameWhenSelected;

/** 是否有选中的画笔 */
@property (nonatomic) BOOL hasSelectedShape;

/**
 开启、关闭画笔
 #param drawingEnabled YES：开启，NO：关闭
 #return NSError:
 #discussion NSErrorCode_invalidCalling    错误调用，当前用户是学生、`drawingGranted` 是 NO
 #discussion 开启画笔时，单文档实例情况下如果本地页数与服务端页数不同步则无法绘制
 #discussion `drawingGranted` 是 YES 时才可以开启，`drawingGranted` 是 NO 时会被自动关闭
 */
- (nullable NSError *)updateDrawingEnabled:(BOOL)drawingEnabled;

/**
 更新画笔操作模式
 #param operateMode 操作模式
 #return NSError:
 #discussion NSErrorCode_invalidCalling drawingEnabled 是 NO
 */
- (nullable NSError *)updateBrushOperateMode:(BJLBrushOperateMode)operateMode;

/**
 添加图片画笔
 #param imageURL 图片 url
 #param relativeFrame 图片相对于画布的 frame, 各项数值取值范围为 [0.0, 1.0]
 #param documentID 目标文档 ID
 #param pageIndex   目标页
 #param isWritingBoard   是否为小黑板
 #return NSErrorCode_invalidCalling drawingEnabled 是 NO
 */
- (nullable NSError *)addImageShapeWithURL:(NSString *)imageURL
                              relativeFrame:(CGRect)relativeFrame
                               toDocumentID:(NSString *)documentID
                                  pageIndex:(NSUInteger)pageIndex
                             isWritingBoard:(BOOL)isWritingBoard;

#pragma mark - 画笔授权

/** 学生是否被授权使用画笔 */
@property (nonatomic, readonly) BOOL drawingGranted;

/** 所有被授权使用画笔的学生 */
@property (nonatomic, readonly, copy) NSArray<NSString *> *drawingGrantedUserNumbers;

/**
 老师、助教: 给学生授权/取消画笔
 #param granted     是否授权
 #param userNumber  要操作的用户
 #param color       分配的画笔颜色
 #return NSError:
 NSErrorCode_invalidUserRole   当前用户不是老师或者助教
 NSErrorCode_invalidArguments  参数错误
 */
- (nullable NSError *)updateDrawingGranted:(BOOL)granted userNumber:(NSString *)userNumber color:(nullable NSString *)color;

#pragma mark - 画笔颜色分配

/** 画笔分配颜色记录 <hex color, user.number> */
@property (nonatomic, readonly, copy) NSDictionary <NSString *, NSString *> *drawingGrantedColors;

/** 是否不使用分配的画笔颜色 */
@property (nonatomic) BOOL shouldRejectColorGranted;

/**
 删除 drawingGrantedColors 中某一位学生的画笔颜色分配记录
 #param userNumber 用户 number
 #return NSError
 */
- (nullable NSError *)deleteColorRecordWithUserNumber:(NSString *)userNumber;

#pragma mark - 小黑板

/** 小黑板画笔开关状态 */
@property (nonatomic, readonly) BOOL writingBoardEnabled;

/**
 开启/关闭小黑板画笔
 #param writingBoardEnabled 是否开启小黑板画笔
 */
- (void)updateWritingBoardEnabled:(BOOL)writingBoardEnabled;

#pragma mark - 激光笔

/**
 大班课文档区域是否绘制激光笔
 默认绘制，为圆点样式，将不回调激光笔位置等监听，并且设置画笔模式为激光笔时不会主动触发激光笔；
 如果设置为不绘制，需要自行实现激光笔效果
 专业小班课不支持设置，默认不自动绘制
 */
@property (nonatomic) BOOL drawsLaserPointer;

/**
 激光笔位置移动请求
 #param location         激光笔目标位置
 #param documentID       激光笔所在文档的 ID
 #param pageIndex        激光笔所在文档页码
 */
- (nullable NSError *)moveLaserPointToLocation:(CGPoint)location
                                     documentID:(nonnull NSString *)documentID
                                      pageIndex:(NSUInteger)pageIndex;

/**
 激光笔位置移动监听
 #param location         激光笔位置
 #param documentID       激光笔所在文档的 ID
 #param pageIndex        激光笔所在文档页码
 */
- (BJLObservable)didLaserPointMoveToLocation:(CGPoint)location
                                  documentID:(NSString *)documentID
                                   pageIndex:(NSUInteger)pageIndex;

#pragma mark - 画笔位置

/**
 BJLDrawingShapeType_doodle 类型的画笔移动位置回调
 #param location         画笔位置，[0, 1] 区间内的坐标
 #param documentID       画笔所在文档的 ID
 #param pageIndex        画笔所在文档页码
 #param color            画笔颜色
 */
- (BJLObservable)didPaintPointMoveToLocation:(CGPoint)location
                                  documentID:(NSString *)documentID
                                   pageIndex:(NSUInteger)pageIndex
                                       color:(nullable UIColor *)color;

/**
 落笔位置点同步
 #param location         画笔位置，[0, 1] 区间内的坐标
 #param documentID       画笔所在文档的 ID
 #param pageIndex        画笔所在文档页码
 */
- (BJLObservable)didMousePointMoveToLocation:(CGPoint)location
                                  documentID:(NSString *)documentID
                                   pageIndex:(NSUInteger)pageIndex;
- (BJLObservable)didMousePointMoveToLocation:(CGPoint)location
                                  documentID:(NSString *)documentID
                                   pageIndex:(NSUInteger)pageIndex
                                       color:(nullable UIColor *)color;

@end

NS_ASSUME_NONNULL_END
