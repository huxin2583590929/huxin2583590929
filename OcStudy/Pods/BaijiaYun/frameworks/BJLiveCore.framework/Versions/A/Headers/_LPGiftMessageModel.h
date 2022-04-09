//
//  _LPGiftMessage.h
//  BJLiveCore
//
//  Created by Randy on 16/3/31.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"

@class _LPGiftModel;
@class BJLUser;

@interface _LPGiftMessageModel : _LPDataModel
@property (strong, nonatomic) _LPGiftModel *gift;
@property (strong, nonatomic) BJLUser *from;
@property (strong, nonatomic) BJLUser *to;//to为nil是发送给自己的

@end
