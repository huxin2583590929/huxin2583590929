//
//  BNRDetailViewController.h
//  HypnoNerd
//
//  Created by HuXin on 2021/7/12.
//

#import <UIKit/UIKit.h>
@class BNRTtem;

NS_ASSUME_NONNULL_BEGIN


@protocol BNRDetailVCDelegate <NSObject>

- (void)addName:(NSString *)name serial:(NSString *)serial value:(NSString *)value;

@end

@interface BNRDetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) id<BNRDetailVCDelegate> delegate;

@property (nonatomic, strong) BNRTtem *item;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *serialLabel;
@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UITextField *serialNumberField;
@property (strong, nonatomic) UITextField *valueField;
@property (strong, nonatomic) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIBarButtonItem *cameraButton;

- (instancetype)initForNewItem:(BOOL)isNew;

@end

NS_ASSUME_NONNULL_END
