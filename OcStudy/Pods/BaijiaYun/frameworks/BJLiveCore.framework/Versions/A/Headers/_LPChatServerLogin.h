//
//  _LPChatServerLogin.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/5/3.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "BJLMessage.h"
@interface _LPChatServerLogin : _LPResRoomModel

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSArray<BJLMessage *> *messageList;
@end
