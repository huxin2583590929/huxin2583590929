//
//  _LPResCommandUDPServer.h
//  BJLiveCore
//
//  Created by Randy on 16/5/18.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResCommandModel.h"

@class _LPIpAddress;

@interface _LPResCommandUDPServer : _LPResCommandModel
@property (strong, nonatomic) _LPIpAddress *server;

@end
