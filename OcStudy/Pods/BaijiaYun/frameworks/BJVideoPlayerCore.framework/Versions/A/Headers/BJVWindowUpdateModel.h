//
//  BJVWindowUpdateModel.h
//  BJVideoPlayerCore
//
//  Created by 辛亚鹏 on 2021/7/5.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BJVWindowDisplayInfo.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const BJVWindowsUpdateAction_open;          // 打开
FOUNDATION_EXPORT NSString *const BJVWindowsUpdateAction_updateRect;    // 移动 & 缩放
FOUNDATION_EXPORT NSString *const BJVWindowsUpdateAction_stick;         // 置顶
FOUNDATION_EXPORT NSString *const BJVWindowsUpdateAction_fullScreen;    // 全屏
FOUNDATION_EXPORT NSString *const BJVWindowsUpdateAction_maximize;      // 最大化
FOUNDATION_EXPORT NSString *const BJVWindowsUpdateAction_restore;       // 还原
FOUNDATION_EXPORT NSString *const BJVWindowsUpdateAction_close;         // 关闭
FOUNDATION_EXPORT NSString *const BJVWindowsUpdateAction_rename;        // 视图标题更新

/** ### 专业版小班课窗口更新 */
@interface BJVWindowUpdateModel : NSObject

/**
 窗口标识符
 
 #discussion 视频窗口：ID 为 `BJLMediaUser` 的 `mediaID`
 #discussion 文档窗口：ID 为 `BJLDoucument` 的 `documentID`
 */
@property (nonatomic) NSString *ID;

// 更新操作，参考 BJVWindowsUpdateAction
@property (nonatomic) NSString *action;

// 如果是连续的更新操作，有下一个操作时，该字段有值，参考 BJVWindowsUpdateAction，仅为了兼容使用，内部收到带有这个字段的信令直接忽略，不会抛出
@property (nonatomic, nullable) NSString *nextAction;

// 是否为视频窗口信息
@property (nonatomic) BOOL isVideo;

// 窗口展示信息
@property (nonatomic) NSArray<BJVWindowDisplayInfo *> *displayInfos;


@end

NS_ASSUME_NONNULL_END
