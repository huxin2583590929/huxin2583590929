//
//  MICrolecture.h
//  HypnoNerd
//
//  Created by HuXin on 2021/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MICrolecture : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic) NSInteger length;
@property (nonatomic, strong) NSURL *preface_url;
@property (nonatomic, strong) NSString *player_url;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
