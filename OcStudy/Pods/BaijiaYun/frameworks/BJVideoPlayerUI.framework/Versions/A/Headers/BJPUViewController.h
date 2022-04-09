//
//  BJPUViewController.h
//  BJVideoPlayerUI
//
//  Created by DLM on 2017/4/26.
//
//

#import <UIKit/UIKit.h>
#import <BJVideoPlayerCore/BJVideoPlayerCore.h>
#import "BJPUVideoOptions.h"

typedef NS_ENUM(NSUInteger, BJVPlayerViewLayoutType) {
    BJVPlayerViewLayoutType_Vertical,
    BJVPlayerViewLayoutType_Horizon
};

NS_ASSUME_NONNULL_BEGIN

@interface BJPUViewController : UIViewController

@property (nonatomic, assign) BJVPlayerViewLayoutType layoutType;
@property (nonatomic, readonly) BJVPlayerManager *playerManager;
@property (nonatomic, copy) void (^ _Nullable cancelCallback)(void);
@property (nonatomic, copy) void (^ _Nullable screenLockCallback)(BOOL locked);

// 系统调用- supportedInterfaceOrientations 时，会返回此值。未设置时为0，会调用父类的实现
@property (nonatomic, assign) UIInterfaceOrientationMask supportedOrientations;

- (instancetype)initWithVideoOptions:(BJPUVideoOptions *)videoOptions;

/** 在线视频播放 */
- (void)playWithVid:(NSString *)vid token:(NSString *)token;

/** 本地视频播放 */
- (void)playWithDownloadItem:(BJVDownloadItem *)downloadItem;

/**
 设置跑马灯
 
 如果官网后台的 云点播-播放器设置-跑马灯设置 没有开启显示跑马灯 或者 customLamp.content == nil, 则无法显示跑马灯
 */
@property (nonatomic, nullable) BJVLamp *customLamp;

@end

NS_ASSUME_NONNULL_END
