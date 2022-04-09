//
//  _LPDocAddModel.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#if __has_feature(modules) && BJL_USE_SEMANTIC_IMPORT
@import BJLiveBase;
#else
#import <BJLiveBase/BJLiveBase.h>
#endif

#import "_LPResRoomModel.h"

@interface _LPResDocAdd : _LPResRoomModel

@property (nonatomic, strong) BJLDocument *document;

@end
