//
//  _LPMediaInfo.h
//  BJLiveCore
//
//  Created by HuangJie on 2019/1/14.
//  Copyright © 2019 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "_LPLinkInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPMediaInfo : NSObject

@property (nonatomic, readonly) BOOL isEmpty;

@property (nonatomic, readonly) __kindof NSDictionary<NSNumber *, _LPLinkInfo *> *linkInfos;

#pragma mark - setter & getter

- (void)updateLinkInfo:(_LPLinkInfo * _Nullable)linkInfo forMediaSource:(BJLMediaSource)mediaSource;

- (_LPLinkInfo *)linkInfoForMediaSource:(BJLMediaSource)mediaSource;

- (void)updateLinkInfo:(_LPLinkInfo *)linkInfo expectMediaSource:(BJLMediaSource)mediaSource;

#pragma mark - mute

- (void)muteAudioForAllLinkInfos:(BOOL)mute;

- (void)muteAudio:(BOOL)mute forMediaSource:(BJLMediaSource)mediaSource;

@end

NS_ASSUME_NONNULL_END
