//
//  AppDelegateAndSceneDelegate.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/14.
//

#import "AppDelegateAndSceneDelegate.h"
#import "BNRUITableTableViewController.h"
#import "BNRBasicsViewController.h"
#import "NETworkingViewController.h"
#import "MICrolectureStartViewController.h"
#import "rgbLabelViewController.h"
#import "TestTableViewController.h"

@implementation AppDelegateAndSceneDelegate

+ (UIViewController *)defaultTabBarViewController {
    BNRUITableTableViewController *ui = [[BNRUITableTableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ui];
    navController.tabBarItem.title = @"UIItems";
    
    BNRBasicsViewController *basics = [[BNRBasicsViewController alloc] init];
    UINavigationController *basicsNavController = [[UINavigationController alloc] initWithRootViewController:basics];
    
    NETworkingViewController *networking = [[NETworkingViewController alloc] init];
    UINavigationController *networkingNavController = [[UINavigationController alloc] initWithRootViewController:networking];
    
    MICrolectureStartViewController *start = [[MICrolectureStartViewController alloc] init];
    UINavigationController *microNavController = [[UINavigationController alloc] initWithRootViewController:start];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[basicsNavController, navController, networkingNavController,microNavController];
    
    //rgbLabelViewController *rgb = [[rgbLabelViewController alloc] init];
    
    TestTableViewController *testTable = [[TestTableViewController alloc] init];
    return testTable;
}

@end
