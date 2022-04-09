//
//  MYAFNetworking.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/22.
//

#import "MYAFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>

@interface MYAFNetworking ()

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation MYAFNetworking

- (instancetype)init {
    self = [super init];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"AFNetworking";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    [self.startButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.startButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(testStart) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.startButton];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
}

- (void)testStart {
    [self bjy_GET:@"http://yapi.baijiashilian.com/mock/11/orgapp/weclass/playbackList"
          success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable data) {
                NSLog(@"success:%@", data);
        
                NSMutableArray *list = data[@"data"][@"list"];
                for (int i = 0; i < list.count; i++) {
                    NSLog(@"list title:%@",list[i][@"title"]);
                }
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error : %@",error);
    }];
    
    //downtask
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://vfx.mtime.cn/Video/2015/07/04/mp4/150704102229172451_480.mp4"]];

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];

    NSURLSessionDownloadTask *downloadTask = [sessionManager downloadTaskWithRequest:request
        progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%f", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        }
        destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];

            NSLog(@"targetpath: %@\nfullpath: %@", targetPath, fullPath);

        return [NSURL fileURLWithPath:fullPath];
        }
        completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"filepath: %@", filePath);
        }
        else {
            NSLog(@"ERROR: %@", error);
        }
    }];

      /*延迟执行时间2秒*/
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [downloadTask resume];
    });
}

- (NSURLSessionDataTask *)bjy_GET:(NSString *)URLString
                      success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                          failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    AFHTTPSessionManager *sessionManager =[AFHTTPSessionManager manager];
    
    return  [sessionManager GET:URLString parameters:nil headers:nil
                       progress:^(NSProgress * _Nonnull downloadProgress) {
                            CGFloat downprogress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                            NSLog(@"%f", downprogress);
                        }
                        success:
             ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *data = responseObject;
            NSLog(@"89757: %@",NSStringFromClass([data[@"code"] class]));
            if ([data[@"code"] integerValue] != 0) {
                NSLog(@"Business error");
                NSError *error = [[NSError alloc] init];
                failure(task,error);
            }
            if (success) {
                success(task, responseObject);
            }
        }

    }
                        failure:failure];
}
@end
