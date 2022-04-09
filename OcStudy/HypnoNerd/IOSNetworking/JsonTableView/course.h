//
//  course.h
//  HypnoNerd
//
//  Created by HuXin on 2021/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface course : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *create_time;
@property (nonatomic) NSString *length;
@property (nonatomic) NSInteger count;


- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
