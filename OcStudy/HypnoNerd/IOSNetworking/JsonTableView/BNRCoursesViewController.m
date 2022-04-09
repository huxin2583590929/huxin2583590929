//
//  BNRCoursesViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/14.
//

#import "BNRCoursesViewController.h"
#import <objc/runtime.h>
#import "course.h"

@interface BNRCoursesViewController ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic,strong) NSMutableArray<course *> *courses;

@end

@implementation BNRCoursesViewController
 

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"BNR Courses";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
        [self fetchFeed];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.courses = [[NSMutableArray alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSString *course = self.courses[indexPath.row].title;
    NSLog(@"course:%@",course);
    cell.textLabel.text = course;
    
    return cell;
}


- (void)fetchFeed {
    NSString *requestString = @"http://yapi.baijiashilian.com/mock/11/orgapp/weclass/playbackList";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && data) {
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", jsonObject);

            for (int i = 0; i < [jsonObject[@"data"][@"list"] count]; i++) {
                course *cour = [[course alloc] initWithDict:jsonObject[@"data"][@"list"][i]];
                [self.courses addObject:cour];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else {
            NSLog(@"ERROR");
        }
    }];
    [dataTask resume];
}

@end
