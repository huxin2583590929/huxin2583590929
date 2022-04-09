//
//  BJLScreenRecordingNotifier.h
//  BJLiveBase
//
//  Created by Ney on 7/13/21.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BJLScreenRecordingNotifier : NSObject
/** 用户是否在录制屏幕，iOS11以上生效，iOS11以下一直是NO */
@property(nonatomic, readonly) BOOL screenRecording;

@property (nonatomic, copy) void (^screenRecordingStateChangeBlock)(BJLScreenRecordingNotifier *notifier, BOOL screenRecording);

- (void)startObserve;
- (void)stopObserve;
@end

NS_ASSUME_NONNULL_END
