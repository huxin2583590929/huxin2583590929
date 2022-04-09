//
//  MYNsurlsession.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/21.
//

#import "MYNsurlsession.h"
#import <Masonry/Masonry.h>

@interface MYNsurlsession () <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *begin;
@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) UIButton *resume;
@property (nonatomic, strong) NSData *resumeData;

@end

@implementation MYNsurlsession

- (instancetype)init {
    self = [super init];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"URLSession";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"background.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    //self.imageView.userInteractionEnabled  = YES;
    
    [self.view addSubview:self.imageView];
    
    self.begin = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.begin setTitle:@"开始" forState:UIControlStateNormal];
    self.begin.backgroundColor = UIColor.redColor;
    
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel setTitle:@"取消" forState:UIControlStateNormal];
    self.cancel.backgroundColor = UIColor.redColor;
    
    self.resume = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resume setTitle:@"恢复" forState:UIControlStateNormal];
    self.resume.backgroundColor = UIColor.redColor;
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(20, self.view.center.y, 300, 20)];
    self.progressView.progressViewStyle = UIProgressViewStyleDefault;
    self.progressView.tintColor = UIColor.redColor;
    self.progressView.trackTintColor = UIColor.whiteColor;
    
    [self.view addSubview:self.begin];
    [self.view addSubview:self.cancel];
    [self.view addSubview:self.resume];
    [self.view addSubview:self.progressView];
    
    [self.begin addTarget:self action:@selector(progressBegin) forControlEvents:UIControlEventTouchUpInside];
    [self.cancel addTarget:self action:@selector(progressCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.resume addTarget:self action:@selector(progressResume) forControlEvents:UIControlEventTouchUpInside];
    
    [self.begin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(140);
        make.right.equalTo(self.cancel.mas_left).mas_offset(-40);
        make.width.equalTo(@60);
        make.height.equalTo(@50);
    }];
    
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.begin);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.begin);
        make.height.equalTo(self.begin);
    }];
    
    [self.resume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancel);
        make.left.equalTo(self.cancel.mas_right).mas_offset(40);
        make.width.equalTo(@60);
        make.height.equalTo(@50);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@300);
    }];
    
    //沙盒路径
//    NSString *directory = NSHomeDirectory();
//     NSLog(@"directory:%@",directory);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%@",location);
    
    //获取保存文件的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"1.mp4"];
    
    NSLog(@"%@",path);
    
    //将url对应的文件copy到指定的路径
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
    
    NSLog(@"下载完成");
}

//获取每次下载的长度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    CGFloat progress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
    self.progressView.progress = progress;
    
    NSLog(@"%f",progress);
}

//下载完成，成功出错都会来到这里
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"%@",error.userInfo);
}

- (void)progressBegin {
    NSLog(@"开始下载");
    NSURL *url = [NSURL URLWithString:@"http://vfx.mtime.cn/Video/2015/07/04/mp4/150704102229172451_480.mp4"];
    if (self.resumeData) {  // 之前已经下载过了
        self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    }
    else {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        self.task = [self.session downloadTaskWithURL:url];
    }
    
    [self.task resume];
}

- (void)progressCancel {
    NSLog(@"取消下载");
    if (self.task) {
        __weak __typeof(self) weakSelf = self;
        [self.task cancelByProducingResumeData:^(NSData *resumeData) {
            NSLog(@"resumeData:%@",resumeData);
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                strongSelf.resumeData = resumeData;
                strongSelf.task = nil;
            }
        }];
    }
}

- (void)progressResume {
    NSLog(@"恢复下载");
    self.task = nil;
    self.session = nil;
    self.resumeData = nil;
    self.progressView.progress = 0;
}

@end
