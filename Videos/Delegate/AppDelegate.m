//
//  AppDelegate.m
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "AppDelegate.h"
#import "MVPlayerViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure *configure) {
//        configure.backStyle             = GKNavigationBarBackStyleWhite;
//        configure.titleFont             = [UIFont systemFontOfSize:18.0f];
//        configure.titleColor            = [UIColor whiteColor];
//        configure.gk_navItemLeftSpace   = 12.0f;
//        configure.gk_navItemRightSpace  = 12.0f;
//        configure.statusBarStyle        = UIStatusBarStyleLightContent;
//        configure.gk_translationX       = 10.0f;
//        configure.gk_translationY       = 15.0f;
//        configure.gk_scaleX             = 0.90f;
//        configure.gk_scaleY             = 0.95f;
//    }];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MVPlayerViewController* vc = [MVPlayerViewController new];
//    ViewController* vc = [ViewController new];
    
//    MVNavViewController *vc = [MVNavViewController rootVC:[MVPlayerViewController new] translationScale:NO];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
