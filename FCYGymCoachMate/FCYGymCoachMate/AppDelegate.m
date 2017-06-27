//
//  AppDelegate.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/2.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"
#import "BaseNavigationController.h"

#import "CYTabBarController.h"
#import "BaseNavigationController.h"
#import "CourseViewController.h"
#import "GymViewController.h"

#import "landViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     * 之前的方法
     */
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    MyTabBarController *tabVC = [[MyTabBarController alloc]init];
//    self.window.rootViewController = tabVC;
//    [self.window makeKeyAndVisible];
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    CYTabBarController *tabbar = [[CYTabBarController alloc]init];
    
    /**
     *  配置外观
     */
    [CYTabBarConfig shared].selectedTextColor = [UIColor blackColor];
    [CYTabBarConfig shared].selectIndex = 1;
    [CYTabBarConfig shared].backgroundColor = Tab_Color;
    
    
    /**
     *  样式1:中间按钮突出 ， 设为按钮 , 底部有文字
     */
//    BaseNavigationController *nav1 = [[BaseNavigationController alloc]initWithRootViewController:[CourseViewController new]];
//    [tabbar addChildController:nav1 title:@"排期计划" imageName:@"tab_discover_normal" selectedImageName:@"tab_discover_selected"];
//    BaseNavigationController *nav2 = [[BaseNavigationController alloc]initWithRootViewController:[GymViewController new]];
//    [tabbar addChildController:nav2 title:@"健身馆" imageName:@"tab_me_normal" selectedImageName:@"tab_me_selected"];
//    [tabbar addCenterController:nil bulge:YES title:@"" imageName:@"post_normal" selectedImageName:@""];
    
    /**
     *  样式2:(中间按钮不突出 ， 设为控制器 ,底部无文字  , 微博)
     */
    BaseNavigationController *nav1 = [[BaseNavigationController alloc]initWithRootViewController:[CourseViewController new]];
    [tabbar addChildController:nav1 title:@"排期计划" imageName:@"pqjh01" selectedImageName:@"pqjh"];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc]initWithRootViewController:[GymViewController new]];
    [tabbar addChildController:nav2 title:@"健身馆" imageName:@"jsg01" selectedImageName:@"jsg"];
    [tabbar addCenterController:nil bulge:NO title:nil imageName:@"xz" selectedImageName:@"xz"];
    
    self.tabbar = tabbar;
    
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:isLogin]) {
        landViewController *landVC = [[landViewController alloc]init];
        [self.window.rootViewController presentViewController:landVC animated:YES completion:nil];
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
