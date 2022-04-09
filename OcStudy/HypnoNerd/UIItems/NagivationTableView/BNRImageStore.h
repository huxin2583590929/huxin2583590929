//
//  BNRImageStore.h
//  HypnoNerd
//
//  Created by HuXin on 2021/7/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;
- (NSString *)imagePathForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
