//
//  _LPDataModel.h
//  BJLiveCore
//
//  Created by Randy on 16/3/23.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#if __has_feature(modules) && BJL_USE_SEMANTIC_IMPORT
@import BJLiveBase;
#else
#import <BJLiveBase/BJLiveBase.h>
#endif

#import "_LPConstants.h"

@interface _LPDataModel : NSObject <BJLYYModel, NSCopying, NSCoding>

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionaryValue;

+ (NSDictionary *)JSONKeyPathsByPropertyKey;
- (void)mergeValuesForKeysFromModel:(id)model;

@end
