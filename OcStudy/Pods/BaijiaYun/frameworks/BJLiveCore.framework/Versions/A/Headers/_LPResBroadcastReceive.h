//
//  _LPResBroadcastReceive.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/31.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import  "_LPResRoomModel.h"

@interface _LPResBroadcastReceive : _LPResRoomModel

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) id value;
@property (nonatomic, readonly) NSDictionary *dictValue;

@end
