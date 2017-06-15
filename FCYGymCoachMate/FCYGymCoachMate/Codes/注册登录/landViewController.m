//
//  landViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/30.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "landViewController.h"
#import "registerViewController.h"
#import "forgetViewController.h"
#import "AppDelegate.h"

#import "CYTabBarController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface landViewController ()<UITextFieldDelegate>

@end

@implementation landViewController {
    NSString  *imUserName;
    NSString  *imPassword;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登陆";
    [self setupUI];
}
- (void)setupUI{
    
    
   UITextField *  phoneField = [[UITextField alloc] initWithFrame:CGRectMake(20, 144 , SCREEN_WIDTH - 40 , 50)];
    phoneField.placeholder = @"手机号";
    phoneField.borderStyle = UITextBorderStyleRoundedRect;
    phoneField.secureTextEntry = YES;
    phoneField.delegate = self;
    UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    phoneLabel.text = @"账号";
    phoneLabel.textAlignment = NSTextAlignmentRight;
    phoneField.leftView = phoneLabel;
    phoneField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:phoneField];
    
    
   UITextField *  passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200 , SCREEN_WIDTH - 40 , 50)];
    passwordField.placeholder = @"请输入密码";
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.secureTextEntry = YES;
    passwordField.delegate = self;
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    passwordLabel.text = @"密码";
    passwordLabel.textAlignment = NSTextAlignmentRight;
    passwordField.leftView = passwordLabel;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:passwordField];
    
    
    UIButton * forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 260,80, 30)];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    UIButton * landBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 370, SCREEN_WIDTH - 40, 50)];
    landBtn.layer.cornerRadius = 5;
    landBtn.clipsToBounds = YES;
    [landBtn setTitle:@"登陆" forState:UIControlStateNormal];
    landBtn.backgroundColor = [UIColor colorWithRed:40/255.0f green:158/255.0f blue:239/255.0f alpha:1.0f];
    [landBtn addTarget:self action:@selector(landBtnClick) forControlEvents:UIControlEventTouchUpInside];
    landBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:landBtn];
    
    
    UIButton * registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 440, SCREEN_WIDTH - 40, 50)];
    registerBtn.layer.cornerRadius = 5;
    registerBtn.clipsToBounds = YES;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.borderWidth = 0.2;
    [self.view addSubview:registerBtn];
    
   
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark --- Events Handel

- (void)forgetBtnClick{
    
    forgetViewController * forgetVC = [[forgetViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:NO];
    
}

- (void)landBtnClick{
    
    imUserName = @"visitor2";
    imPassword = @"taobao1234";
    
    // 跳到主界面
    
    
}

- (void)registerClick{
    
    registerViewController * registerVC = [[registerViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:NO];
    
    
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
