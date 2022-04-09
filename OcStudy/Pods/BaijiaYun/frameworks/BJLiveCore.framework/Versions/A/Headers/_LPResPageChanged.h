//
//  _LPPageChangedModel.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

@interface _LPResPageChanged : _LPResRoomModel

@property (nonatomic) NSString *documentID;
@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger step;
@property (nonatomic) NSDictionary *event;

@end
