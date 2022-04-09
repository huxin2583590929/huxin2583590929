//
//  BNRTtem.h
//  HypnoNerd
//
//  Created by HuXin on 2021/7/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRTtem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic,strong) UIImageView *itemImage;
@property (nonatomic, copy) NSString *itemKey;

+ (instancetype)randomItem;

- (instancetype)initWithItemName: (NSString *)name valueInDollars: (int)value serialNumber: (NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
