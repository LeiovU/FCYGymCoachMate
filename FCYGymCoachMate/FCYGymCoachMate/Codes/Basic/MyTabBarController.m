//
//  MyTabBarController.m
//  MeiTuanDemo
//
//  Created by Fangcy on 2017/3/24.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "MyTabBarController.h"
#import "BaseNavigationController.h"

#import "CourseViewController.h"
#import "GymViewController.h"
#import "MeViewController.h"


#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"CourseViewController",
                                   kTitleKey  : @"课程",
                                   kImgKey    : @"icon_tabbar_homepage",
                                   kSelImgKey : @"icon_tabbar_homepage_selected"},
                                 
                                 @{kClassKey  : @"GymViewController",
                                   kTitleKey  : @"健身房",
                                   kImgKey    : @"icon_tabbar_merchant_normal",
                                   kSelImgKey : @"icon_tabbar_merchant_selected"},
                                 
                                 @{kClassKey  : @"MeViewController",
                                   kTitleKey  : @"我",
                                   kImgKey    : @"icon_tabbar_mine",
                                   kSelImgKey : @"icon_tabbar_mine_selected"}
                                 ];
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * stop) {
        UIViewController *vc;
        vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
        
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : kThemeColor} forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
        
        
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
