//
//  _LPResCommandModel.h
//  BJLiveCore
//
//  Created by Randy on 16/5/18.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"

@class BJLUser, _LPResCommandModel;

@interface _LPResCommandModel : _LPDataModel
@property (copy, nonatomic) NSString *messageType;
@property (copy, nonatomic) NSString *commandType;
@property (copy, nonatomic) NSDictionary *data;
@property (copy, nonatomic) NSString *from;
@property (copy, nonatomic) NSString *to;

- (instancetype)initWithCommandModel:(_LPResCommandModel *)model;

@end
