//
//  _LPResHomeworkAll.h
//  BJLiveCore
//
//  Created by 凡义 on 2020/8/25.
//  Copyright © 2020 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "BJLHomework.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResHomeworkAll : _LPResRoomModel

@property (nonatomic, nullable) NSString *keyword;
@property (nonatomic) NSArray<BJLHomework *> *homeworks;
@property (nonatomic) BOOL hasMore;

@end

NS_ASSUME_NONNULL_END
