//
//  AvatarBackgroundColorGenerator.h
//  testOC
//
//  Created by HuXin on 2021/9/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvatarBackgroundColorGenerator : NSObject
+ (UIColor *)backgroundColorWithUserNumber:(NSString *)userNumber;
+ (nullable UIColor *)bjl_colorWithHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
