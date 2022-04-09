//
//  BJVRoom.h
//  Pods
//
//  Created by 辛亚鹏 on 2016/12/14.
//  Copyright (c) 2016 Baijia Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BJVPlayerManager.h"
#import "BJVOnlineUserVM.h"
#import "BJVRoomVM.h"
#import "BJVMessageVM.h"

#import "BJVPlaybackInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 教室
 可同时存在多个实例
 */
@interface BJVRoom : NSObject

/** 是否是本地视频 */
@property (nonatomic, readonly) BOOL isLocalVideo;

/** 是否是小班课 */
@property (nonatomic, readonly) BOOL isInteractiveClass;

/** 是否正在加载 */
@property (nonatomic, readonly) BOOL loading;

/** 回放房间信息 */
@property (nonatomic, readonly, nullable) BJVRoomVM *roomVM;

/** 聊天消息 */
@property (nonatomic, readonly, nullable) BJVMessageVM *messageVM;

/** 在线用户 */
@property (nonatomic, readonly, nullable) BJVOnlineUserVM *onlineUsersVM;

/** 播放控制器 */
@property (nonatomic, readonly, nullable) id<BJVPlayProtocol> playerManager;

/** 课件显示 */
@property (nonatomic, readonly, nullable) UIViewController<BJLSlideshowUI> *slideshowViewController;

/** 裁剪后的回放视频version, 需要在调用enter之前设置 */
@property (nonatomic) NSInteger clipedVersion;

/** 是否禁用动态课件, default: NO */
@property (nonatomic) BOOL disablePPTAnimation;

/** 是否存在 h5 课件（指除了 ppt, pptx 类型的动画课件
 如果存在，不能设置成禁用动画课件，并且建议联网观看，否则无网络的离线回放将无法加载 */
@property (nonatomic, readonly) BOOL existWebDocument;

/** 回放房间的相关信息 */
@property (nonatomic, readonly) BJVPlaybackInfo *playbackInfo;

/** 本地房间的相关信息 */
@property (nonatomic, readonly) BJVDownloadItem *downloadItem;

#pragma mark - initialize

/**
 Unavailable. Please use method: onlinePlaybackRoomWithClassID:sessionID:token: | localPlaybackRoomWithDownloadItem:playerType:
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 创建在线回放房间，配置项采用默认值
 
 #discussion 具体参考 `onlinePlaybackRoomWithClassID:sessionID:token:encrypted:playerType:` 方法
 #discussion 视频不加密
 #discussion 使用 AVPlayer
 
 #param classID     课程 ID
 #param sessionID   课节 ID
 #param token       需要集成方后端调用百家云后端的API获取，传给移动端
 #return            回放房间实例
 */
+ (instancetype)onlinePlaybackRoomWithClassID:(NSString *)classID
                                    sessionID:(nullable NSString *)sessionID
                                        token:(NSString *)token;

/**
 创建在线回放房间
 
 #param classID     课程 ID
 #param sessionID   课节 ID
 #param token       需要集成方后端调用百家云后端的API获取，传给移动端
 #param encrypted   是否加密，「仅在使用 IJKPlayer 时有效」，playerType 参数传 BJVPlayerType_IJKPlayer
 #param accessKey   集成方鉴权, 回放如果需要请求第三方服务器查看是否有权限, 可设置该参数。鉴权验证请求需要与百家云后台沟通。
 #param playerType  播放器类型：AVPlayer、IJKPlayer
 #return            回放房间实例
 */
+ (instancetype)onlinePlaybackRoomWithClassID:(NSString *)classID
                                    sessionID:(nullable NSString *)sessionID
                                        token:(NSString *)token
                                    encrypted:(BOOL)encrypted
                                    accessKey:(nullable NSString *)accessKey
                                   playerType:(BJVPlayerType)playerType;

/**
 创建本地回放房间
 
 #param downloadItem    本地回放文件类型，通过下载模块获得
 #param playerType      播放器类型：AVPlayer、IJKPlayer
 #return                回放房间实例
 */
+ (instancetype)localPlaybackRoomWithDownloadItem:(BJVDownloadItem *)downloadItem
                                       playerType:(BJVPlayerType)playerType;

#pragma mark - enter

/**
 进入教室
 */
- (void)enter;

/**
 进入教室
 #param error 成功进入教室, error为空, 错误码参考 BJVErrorCode
 case: 在线播放, 获取playbackVM的播放信息
 case: 本地视频, 信令文件解压完毕, 并载入内存，播放器加载视频完成
 */
- (BJLObservable)roomDidEnterWithError:(nullable NSError *)error;

#pragma mark - exit

/**
 退出教室
 */
- (void)exit;

/**
 退出教室事件，成功退出, error为空, 错误码参考 BJVErrorCode
 */
- (BJLObservable)roomDidExitWithError:(nullable NSError *)error;

#pragma mark - reload

/**
 重新加载房间内容
 
 #discussion 用于回放过程中出错后重试。
 */
- (void)reload;

#pragma mark - debug

@property (nonatomic, copy, nullable) void (^signalConsoleInfoCallback)(NSString *signalInfo);
@property (nonatomic, copy, nullable) void (^signalClearCallback)(void);
@property (nonatomic, copy, nullable, setter = setAPIConsoleInfoCallback:) void (^apiConsoleInfoCallback)(NSString *consoleInfo);

@end

NS_ASSUME_NONNULL_END
