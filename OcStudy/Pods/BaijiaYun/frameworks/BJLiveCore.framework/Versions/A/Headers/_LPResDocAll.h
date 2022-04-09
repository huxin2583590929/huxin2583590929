//
//  _LPDocAllModel.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "BJLDocument.h"

@interface _LPResDocAll : _LPResRoomModel


@property (nonatomic) NSString *currentDocumentID;
@property (nonatomic) NSUInteger currentPage;
@property (nonatomic) NSUInteger currentStep;

@property (nonatomic) NSArray<BJLDocument *> *documents;

@end
