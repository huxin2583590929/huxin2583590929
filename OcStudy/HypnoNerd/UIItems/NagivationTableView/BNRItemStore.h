//
//  BNRItemStore.h
//  HypnoNerd
//
//  Created by HuXin on 2021/7/9.
//

#import <Foundation/Foundation.h>

@class BNRTtem;

NS_ASSUME_NONNULL_BEGIN

@interface BNRItemStore : NSObject

+ (instancetype)sharedStore;

- (BNRTtem *)createItem;

- (BOOL)saveChanges;
- (NSArray *)allItems;
- (void)removeItem:(BNRTtem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromInndex ToIndex:(NSUInteger)toIndex;

@end

NS_ASSUME_NONNULL_END
