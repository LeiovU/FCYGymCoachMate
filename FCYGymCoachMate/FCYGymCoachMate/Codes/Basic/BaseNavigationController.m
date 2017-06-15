//
//  BaseNavigationController.m
//  MeiTuanDemo
//
//  Created by Fangcy on 2017/3/24.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 通过UIAppearance设置一些UI的全局效果
    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.barTintColor = RGB(33, 192, 174);
    [bar setBackgroundImage:[UIImage imageNamed:@"bj_01"] forBarMetrics:UIBarMetricsDefault];
    
    bar.tintColor = [UIColor whiteColor];
    
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont systemFontOfSize:20]};
    
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.viewControllers.count) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置状态栏style
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
