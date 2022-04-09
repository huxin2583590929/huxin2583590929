//
//  BNRDetailViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/12.
//

#import "BNRDetailViewController.h"
#import "BNRItemStore.h"
#import "BNRTtem.h"
#import <Masonry/Masonry.h>
#import "AppDelegate.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController ()

@end

@implementation BNRDetailViewController

- (instancetype)initForNewItem:(BOOL)isNew {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;

            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem:" userInfo:nil];

    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.nameLabel = [[UILabel alloc] init];
    self.nameField = [[UITextField alloc] init];
    self.serialLabel = [[UILabel alloc] init];
    self.serialNumberField = [[UITextField alloc] init];
    self.valueLabel = [[UILabel alloc] init];
    self.valueField = [[UITextField alloc] init];
    self.dateLabel = [[UILabel alloc] init];
    self.imageView = [[UIImageView alloc] init];
    
    self.nameLabel.text = @"Name";
    self.serialLabel.text = @"Serial";
    self.valueLabel.text = @"Value";
    
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.serialNumberField.borderStyle = UITextBorderStyleRoundedRect;
    self.valueField.borderStyle = UITextBorderStyleRoundedRect;

    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, 320, 30)];
    self.cameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    self.toolBar.items =[NSArray arrayWithObjects:self.cameraButton, nil];
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.serialLabel];
    [self.view addSubview:self.serialNumberField];
    [self.view addSubview:self.valueLabel];
    [self.view addSubview:self.valueField];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.toolBar];
    
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.serialLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel.textAlignment = NSTextAlignmentCenter;

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(75, 10, 0, 0));
        make.right.equalTo(self.nameField.mas_left).mas_offset(-5);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel);
        make.right.equalTo(self.view).mas_offset(-10);
        make.height.equalTo(self.nameLabel);
    }];
    
    [self.serialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(20);
        make.left.equalTo(self.view).mas_offset(10);
        make.width.equalTo(self.nameLabel);
        make.height.equalTo(self.nameLabel);
    }];
    
    [self.serialNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serialLabel);
        make.right.equalTo(self.nameField);
        make.left.equalTo(self.serialLabel.mas_right).mas_offset(5);
        make.height.equalTo(self.serialLabel);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serialLabel.mas_bottom).mas_offset(20);
        make.left.equalTo(self.view).mas_offset(10);
        make.width.equalTo(self.serialLabel);
        make.height.equalTo(self.serialLabel);
    }];
    
    [self.valueField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueLabel);
        make.right.equalTo(self.serialNumberField);
        make.left.equalTo(self.valueLabel.mas_right).mas_offset(5);
        make.height.equalTo(self.valueLabel);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueField.mas_bottom).mas_offset(10);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 20, 0, 20));
        make.height.equalTo(@40 );
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 10, 10));
        make.top.equalTo(self.dateLabel.mas_bottom).mas_offset(5);
        make.bottom.equalTo(self.toolBar.mas_top).mas_offset(-0);
    }];
    
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 50, 0));
        make.height.equalTo(@50);
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
    [self prepareViewsForOrientation:io];
    
    BNRTtem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRTtem *item = self.item;
    
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    
//    int newValue = [self.valueField.text intValue];
//
//    if (newValue != item.valueInDollars) {
//        item.valueInDollars = newValue;
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setInteger:newValue forKey:BNRNextItemValuePrefsKey];
//    }
    item.valueInDollars = [self.valueField.text intValue];
    item.itemImage.image = self.imageView.image;
}

- (void)setItem:(BNRTtem *)item {
    _item  = item;
    self.navigationItem.title = _item.itemName;
}

- (void)save:(id)sender {
    NSLog(@"save");
    BNRTtem *item = self.item;
    
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];

    if ([self.delegate respondsToSelector:@selector(addName:serial:value:)]) {
        [self.delegate addName:self.nameField.text serial:self.serialNumberField.text value:self.valueField.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender {
    [[BNRItemStore sharedStore] removeItem:self.item];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"设置图片"
                                                                           message:@"请选择设置图片的方式"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
              
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
                                                                    imagePicker.delegate = self;
                                                                    
                                                                    [self presentViewController:imagePicker animated:YES completion:nil];
                                                                  }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                                    
                                                                    imagePicker.delegate = self;
                                                                    
                                                                    [self presentViewController:imagePicker animated:YES completion:nil];
                                                                  }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    self.item.itemImage.image = image;
    self.imageView.image = self.item.itemImage.image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    }
    else {
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self prepareViewsForOrientation:toInterfaceOrientation];
}
@end
