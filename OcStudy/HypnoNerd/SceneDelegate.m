//
//  SceneDelegate.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/7.
//

#import "SceneDelegate.h"
#import "BNRItemStore.h"
#import "AppDelegateAndSceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)) {
    if (scene) {
        if (@available(iOS 13.0, *)) {
            UIWindowScene *windowScene=(UIWindowScene*)scene;
            self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
            self.window.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
           self.window.rootViewController = [AppDelegateAndSceneDelegate defaultTabBarViewController];
           [self.window makeKeyAndVisible];
        } else {
        
        }
     }

}


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the c API_AVAILABLE(ios(13.0))hanges made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    BOOL success = [[BNRItemStore sharedStore] saveChanges];
    
    if (success) {
        NSLog(@"Save all of the BNRItems");
    }
    else {
        NSLog(@"Could not save any of the BNRItems");
    }
}


@end
