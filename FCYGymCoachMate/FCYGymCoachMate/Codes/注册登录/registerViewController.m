//
//  registerViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/30.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "registerViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface registerViewController ()<UITextFieldDelegate>
{
    NSTimer * _timer;
}
@property(nonatomic,strong) UITextField * phoneNumTF;

@property(nonatomic,strong) UITextField * passwordTF;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
     _timer = [ NSTimer   scheduledTimerWithTimeInterval: 1 target:self selector:@selector(countdown) userInfo: nil repeats:YES];
    [_timer setFireDate:[NSDate  distantFuture]];

    
}

#pragma mark --- Help methods

- (void)setupUI
{    self.navigationItem.title = @"注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(submitBarItem)];
    [self.phoneNumTF becomeFirstResponder];
    [self.view addSubview:_phoneNumTF];
    [self.view addSubview:self.passwordTF];
    
    UIButton * agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 210, 15, 15)];
    agreeBtn.layer.borderWidth = 0.5;
    agreeBtn.layer.borderColor = [UIColor blueColor].CGColor;
    [agreeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:agreeBtn];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 210, 250, 15)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并且同意该用户协议"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(9,4)];
    label.attributedText = str;
    [self.view addSubview:label];
    
}

#pragma mark --- Events Handel

- (void)submitBarItem{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)agreeBtnClick:(UIButton *)btn{
    static int isAgree = 0;
    if (!isAgree) {
        [btn setTitle:@"√" forState:UIControlStateNormal];
        isAgree = 1;
        
    }else{
        [btn setTitle:@"" forState:UIControlStateNormal];
        isAgree = 0;
    }
   
}
- (void)sendpasswordClick:(id)sender{
    
    UIButton * passwordBtn = (UIButton *)_phoneNumTF.rightView;
    passwordBtn.backgroundColor = [UIColor colorWithRed:117.0/255.0f green:203.0/255.0f blue:60.0/255.0f alpha:1.0f];
    [passwordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [passwordBtn setTitle:@"(60s)后再获取" forState:UIControlStateNormal];
    passwordBtn.userInteractionEnabled = NO;
    
    [_timer  setFireDate:[NSDate distantPast]];
}
//倒计时
- (void)countdown{
    
   UIButton * passwordBtn = (UIButton *)_phoneNumTF.rightView;
  static  int i = 60;
  [passwordBtn setTitle:[NSString stringWithFormat:@"(%d)后再获取",i--] forState:UIControlStateNormal];
    if (i == -1) {
       [_timer  setFireDate:[NSDate distantFuture]];
        passwordBtn.userInteractionEnabled = YES;
        i = 60;
     [passwordBtn setTitle:@"(60s)后再获取" forState:UIControlStateNormal];
    }
}
#pragma mark --- UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_phoneNumTF == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"温馨提示"                                                                             message:@"输入的手机号码位数超过了11位"                                                                       preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController: alertController animated: YES completion: nil];
        }
    }
    return YES;
}

#pragma mark --- Getter

- (UITextField * )phoneNumTF
{
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 84, SCREEN_WIDTH - 40 , 50)];
        _phoneNumTF.delegate = self;
        _phoneNumTF.placeholder = @"请输入手机号码";
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 130, 50)];
        button.backgroundColor = [UIColor grayColor];
        [button setTitle:@"获取初始密码" forState:UIControlStateNormal];
        button.tag = 10;
        [button addTarget:self action:@selector(sendpasswordClick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1.0f];
        [button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
        _phoneNumTF.rightView = button;
        _phoneNumTF.rightViewMode =  UITextFieldViewModeAlways;
        _phoneNumTF.borderStyle = UITextBorderStyleRoundedRect;
        _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumTF.textColor = [UIColor blackColor];
    }
    return _phoneNumTF;
}

- (UITextField * )passwordTF
{
    if (_passwordTF == nil) {
        _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(20,140, SCREEN_WIDTH - 40 , 50)];
        _passwordTF.delegate = self;
        _passwordTF.placeholder = @"请输入初始密码";
        _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTF.secureTextEntry = YES;
        _passwordTF.layer.borderColor = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:206/255.0f alpha:1.0f].CGColor;
        _passwordTF.textColor = [UIColor blackColor];
    }
    return _passwordTF;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_timer invalidate];
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
