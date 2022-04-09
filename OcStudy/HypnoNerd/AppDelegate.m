//
//  AppDelegate.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/7.
//

#import "AppDelegate.h"
#import "BNRItemStore.h"
#import "AppDelegateAndSceneDelegate.h"
#import <UserNotifications/UserNotifications.h>

NSString * const BNRNextItemValuePrefsKey = @"NextItemValue";
NSString * const BNRNextItemNamePrefsKey = @"NextItemName";


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)initialize {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *factorySettings = @{BNRNextItemValuePrefsKey: @75, BNRNextItemNamePrefsKey: @"Coffee Cup"};
    
    [defaults registerDefaults:factorySettings];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [AppDelegateAndSceneDelegate defaultTabBarViewController];
    [self.window makeKeyAndVisible];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
     [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
             
         }];
        
    return YES;
}



#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    BOOL success = [[BNRItemStore sharedStore] saveChanges];
    
    if (success) {
        NSLog(@"Save all of the BNRItems");
    }
    else {
        NSLog(@"Could not save any of the BNRItems");
    }
}

@end
