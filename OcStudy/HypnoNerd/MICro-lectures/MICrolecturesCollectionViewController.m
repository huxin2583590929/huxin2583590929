//
//  MICro_lecturesViewControllerCollectionViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/26.
//

#import "MICrolecturesCollectionViewController.h"
#import "MICrolectureCollectionViewCell.h"
#import "MICrolecture.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import <BJVideoPlayerUI/BJVideoPlayerUI.h>
#import <BJVideoPlayerCore/BJVAppConfig.h>

@interface MICrolecturesCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *microCollectionView;
@property (nonatomic, strong) NSMutableArray<MICrolecture *> *microlectures;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) BJPUViewController *player;
@property (nonatomic) int page;
@property (nonatomic) int page_size;

@end

@implementation MICrolecturesCollectionViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = [NSString stringWithFormat:@"MicroLectures(%lu)",(unsigned long)self.microlectures.count];
        
        self.page = 1;
        self.page_size = 20;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.microlectures = [[NSMutableArray alloc] init];
    [[BJVAppConfig sharedInstance] setPrivateDomainPrefix:@"e83248690"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(160, 180);
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    
    self.microCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    
    self.microCollectionView.delegate = self;
    self.microCollectionView.dataSource = self;
    self.microCollectionView.backgroundColor = [UIColor whiteColor];
    self.microCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __weak __typeof(self) weakSelf = self;
        weakSelf.page = 1;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%d",weakSelf.page] forKey:@"page"];
        [dict setObject:[NSString stringWithFormat:@"%d",weakSelf.page_size] forKey:@"page_size"];
        [weakSelf.microCollectionView.mj_footer resetNoMoreData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.microlectures removeAllObjects];
            [weakSelf.microCollectionView reloadData];
            [weakSelf getMicrolectures:dict];
            [weakSelf.microCollectionView.mj_header endRefreshing];
        });
    }];
    self.microCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        __weak __typeof(self) weakSelf = self;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%d",weakSelf.page] forKey:@"page"];
        [dict setObject:[NSString stringWithFormat:@"%d",weakSelf.page_size] forKey:@"page_size"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf getMicrolectures:dict];
            [weakSelf.microCollectionView.mj_footer endRefreshing];
        });
    }];
    
    [self.microCollectionView registerClass:[MICrolectureCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.microCollectionView];
    
    [self.microCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.indicatorView.hidesWhenStopped = YES;
    [self.indicatorView setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    [self.indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.microCollectionView addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%d",self.page_size] forKey:@"page_size"];
    
    [self getMicrolectures:dict];
}

- (void)getMicrolectures:(NSDictionary *)dict {
    AFHTTPSessionManager *sessionManager =[AFHTTPSessionManager manager];
    NSString *url = @"https://e83248690.test-at.baijiayun.com/orgapp/weclass/playbackList?auth_token=DH8md3l0aXZjdGV2eHNqd2RuaSc_PTg3OT48PzYyKHN1aG9yaylBOD8-PT09PT4-Pj80Knx7KkI5Pjo_Oz48Qj09NSt7eHVuK0Q7Nix9a3Z-LEQsZESCfEKCLYg&page=1&page_size=20&room_id=&signature=9994ecca48b733689563e919d0449eb8&timestamp=1627354203275&uuid=1726E699-6255-4ED4-A4E1-1E040F38673B";
    
    [sessionManager GET:url parameters:dict headers:nil
               progress:^(NSProgress * _Nonnull downloadProgress) {
        //CGFloat downprogress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        //NSLog(@"%f", downprogress);
    }
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.indicatorView stopAnimating];
        if ([responseObject[@"data"][@"list"] count] < self.page_size) {
            [self.microCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        else {
            self.page += 1;
        }
        for (int i = 0; i < [responseObject[@"data"][@"list"] count]; i++) {
            MICrolecture *lecture = [[MICrolecture alloc] initWithDict:responseObject[@"data"][@"list"][i][@"video_info"]];
            [self.microlectures addObject:lecture];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.microCollectionView reloadData];
        });
        self.navigationItem.title = [NSString stringWithFormat:@"MicroLectures(%lu)",(unsigned long)self.microlectures.count];
    }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR: %@",error);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.microlectures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MICrolectureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell setCellView:self.microlectures[indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MICrolecture *lec = self.microlectures[indexPath.row];
    
    NSArray<NSURLQueryItem *> *items = [NSURLComponents componentsWithString:lec.player_url].queryItems;
    
    NSString *vid = nil;
    NSString *token = nil;
    
    for (NSURLQueryItem *i in items) {
        if ([i.name isEqualToString:@"vid"]) {
            vid = i.value;
        }
        if ([i.name isEqualToString:@"token"]) {
            token = i.value;
        }
        if (!vid && !token) {
            break;
        }
    }
    
    if (vid == nil || token == nil) {
        NSLog(@"ERROR");
        return;
    }
    
    self.player = [[BJPUViewController alloc] initWithVideoOptions: [[BJPUVideoOptions alloc] init]];
    self.player.modalPresentationStyle = UIModalPresentationFullScreen;
    
    __weak typeof(self) weakSelf = self;
    
    // 退出回调
    [self.player setCancelCallback:^{
//        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        [weakSelf.player dismissViewControllerAnimated:YES completion:nil];
    }];
    
    // 锁屏回调
    [self.player setScreenLockCallback:^(BOOL locked) {
    }];
    
    [self presentViewController:self.player animated:YES completion:^{
        [weakSelf.player playWithVid:vid token:token];
    }];
}

@end
