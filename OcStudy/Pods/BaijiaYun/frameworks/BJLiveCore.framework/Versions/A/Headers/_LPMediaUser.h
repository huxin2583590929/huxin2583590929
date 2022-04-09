//
//  _LPMediaUser.h
//  BJLiveCore
//
//  Created by MingLQ on 2016-04-28.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "BJLMediaUser+protected.h"
#import "_LPIpAddress.h"
#import "_LPMediaPublish.h"

// 从信令中解析出 BJLMediaSource 类型，兼容新老版本
static inline BJLMediaSource BJLMediaSourceWithInfo(NSDictionary *mediaInfo) {
    // 新版信令格式，支持单一用户的多路音视频流
    if (![mediaInfo.allKeys containsObject:@"media_id"]) {
        if ([mediaInfo bjl_boolForKey:@"is_screen_sharing"]) {
            return BJLMediaSource_screenShare;
        }
        else {
            return BJLMediaSource_mainCamera;
        }
    }
    NSInteger mediaID = [mediaInfo bjl_integerForKey:@"media_id"];
    switch (mediaID) {
        case 0:
            // 主摄像头采集
            return BJLMediaSource_mainCamera;
            
        case 2:
            // 播放媒体文件
            return BJLMediaSource_mediaFile;
            
        case 3:
            // 屏幕共享
            return BJLMediaSource_screenShare;
            
        case 4:
            // 辅助摄像头屏幕共享
            return BJLMediaSource_extraScreenShare;
            
        case 5:
            // 辅助媒体播放
            return BJLMediaSource_extraMediaFile;
            
        default:
            // 1 或者 userID + x，辅助摄像头采集
            return BJLMediaSource_extraCamera;
    }
}

@interface _LPMediaUser : BJLMediaUser

@property (nonatomic, copy) NSString *classID;
@property (nonatomic) BJLLinkType linkType;
@property (nonatomic) NSInteger publishIndex;
@property (nonatomic) _LPIpAddress *publishServer;
@property (nonatomic) NSString *publishSessionID;
@property (nonatomic) NSDictionary *webRTCInfo;

- (void)setAudioOn:(BOOL)audioOn videoOn:(BOOL)videoOn;

@end
