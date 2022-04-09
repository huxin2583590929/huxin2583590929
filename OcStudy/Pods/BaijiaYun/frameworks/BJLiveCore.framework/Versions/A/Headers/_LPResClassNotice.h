//
//  _LPResClassNotice.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/31.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

@class BJLMessage;

// 获取 修改后 的公告栏/置顶消息
@interface _LPResClassNoticeChange : _LPResRoomModel

@property (nonatomic, copy, nullable) NSString *content, *link;
@property (nonatomic) NSInteger group;
@property (nonatomic) BOOL isSticky;
// 是置顶消息时,stickyList是置顶消息的列表
@property (nonatomic, copy, nullable) NSArray <BJLMessage *> *stickyList;

@end

// 获取公告栏/置顶消息
@interface _LPResClassNotice : _LPResRoomModel
//大班的公告信息
@property (nonatomic, copy, nullable) NSString *content, *link;

// 区分是否为置顶消息
@property (nonatomic) BOOL isSticky;

//当前登录用户所在小组内通知信息
@property (nonatomic, copy, nullable) NSArray <_LPResClassNoticeChange *> *groupNoticeList;

// 是置顶消息时,stickyList是置顶消息的列表
@property (nonatomic, copy, nullable) NSArray <BJLMessage *> *stickyList;

@end
