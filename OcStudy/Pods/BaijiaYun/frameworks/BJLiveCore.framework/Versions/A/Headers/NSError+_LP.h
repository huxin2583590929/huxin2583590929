//
//  NSError+_LP.h
//  BJLiveCore
//
//  Created by Randy on 16/4/28.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (_LP)

+ (NSError *)_LP_errorWithErrorCode:(NSInteger)code reason:(NSString *)reason;

@end
