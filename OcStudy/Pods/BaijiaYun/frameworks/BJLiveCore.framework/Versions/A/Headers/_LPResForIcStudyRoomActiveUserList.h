//
//  _LPResForIcStudyRoomActiveUserList.h
//  BJLiveCore
//
//  Created by Ney on 12/9/20.
//  Copyright © 2020 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "BJLStudyRoomActiveUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResForIcStudyRoomActiveUserList : _LPResRoomModel
@property (nonatomic, readonly) NSArray<BJLStudyRoomActiveUser*> *users;
@end

NS_ASSUME_NONNULL_END
