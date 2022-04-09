//
//  _LPResActiveUserAdd.h
//  BJLiveCore
//
//  Created by HuangJie on 2018/12/3.
//  Copyright © 2018 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "_LPMediaUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResRoomActiveUserAdd : _LPResRoomModel

@property (nonatomic, readonly) _LPMediaUser *user;
// 上台请求被拒绝时返回的状态码：1.上麦人数超出最大限制；2.学生已离开教室。
@property (nonatomic, readonly) NSInteger responseCode;

@end

NS_ASSUME_NONNULL_END
