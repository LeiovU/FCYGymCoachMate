//
//  FCYRootViewController.m
//  FCYPushAndPop01
//
//  Created by bwfstu on 16/2/29.
//  Copyright © 2016年 ancaifcy. All rights reserved.
//

#import "FCYRootViewController.h"

@interface FCYRootViewController ()

@end

@implementation FCYRootViewController


-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationItemsWithTitle:nil andWithImage:[UIImage imageNamed:@"back"] andWithType:YES andWithTag:Back_Tag];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)onBarButtonClick:(UIButton *)sender {
    if (sender.tag == 111) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
