//
//  _LPResUserModel.h
//  BJLiveCore
//
//  Created by HuangJie on 2019/7/24.
//  Copyright © 2019 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResUserModel : _LPResRoomModel

// 回放信令时间戳
@property (nonatomic, assign) NSInteger offsetTimestamp;

// 回放信令毫秒级时间戳
@property (nonatomic, assign) NSInteger msOffsetTimestamp;

// model 在数组中的序号，主要用于回放 debug 面板，将 model 与原始信令对应起来。
@property (nonatomic, assign) NSInteger modelIndex;

@end

NS_ASSUME_NONNULL_END
