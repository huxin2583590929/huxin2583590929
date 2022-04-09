//
//  _LPGiftModel.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"
#import "BJLConstants.h"

@interface _LPGiftModel : _LPDataModel

@property (assign, nonatomic) BJLGiftType type;
@property (copy, nonatomic) NSString *amount;
@property (assign, nonatomic) NSTimeInterval timestamp;

@property (copy, nonatomic) NSString *name;

@end
