//
//  _LPResRoomUserCountChange.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResUserModel.h"

@interface _LPResRoomUserCountChange : _LPResUserModel
@property (assign, nonatomic) NSInteger userCount;
@property (assign, nonatomic) NSInteger accumulativeUserCount;
@property (nonatomic) NSDictionary *groupCountDic;

@end
