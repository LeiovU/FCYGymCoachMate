//
//  landViewController.m
//  FCYGymCoachMate
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

@interface landViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate> {
    NSTimer * _timer;
    BOOL _isLoginVerify;
}

@property (nonatomic,strong) UIButton *loginBtn;   // 登录
@property (nonatomic,strong) UIButton *registerBtn;  // 注册
@property (nonatomic,strong) UILabel *moveLab;


@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIImageView *logoImg;

@property (nonatomic,strong) UIButton *accountBtn;  // 账号密码
@property (nonatomic,strong) UIButton *fastLand;   // 快速登录


@property (nonatomic,strong) UITextField *phoneField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UIButton *landBtn;
@property (nonatomic,strong) UILabel *moveLine;

@property (nonatomic,strong) UITextField *phoneNum;
@property (nonatomic,strong) UITextField *verifyCode;

//  注册界面
@property (nonatomic,strong) UITextField *phone;
@property (nonatomic,strong) UITextField *verify;
@property (nonatomic,strong) UITextField *nickname;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UIButton *signUp;


@end

@implementation landViewController {
    NSString  *imUserName;
    NSString  *imPassword;
}

#pragma mark -- 懒加载
-(UILabel *)moveLab {
    if (!_moveLab) {
        _moveLab = [[UILabel alloc]init];
        _moveLab.backgroundColor = [UIColor blueColor];
    }
    return _moveLab;
}


-(UIScrollView *)scroll {
    if (!_scroll) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.contentSize = CGSizeMake(2*kScreenWidth, 0);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.userInteractionEnabled = YES;
        scrollView.scrollsToTop = YES;
        scrollView.scrollEnabled = YES;
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
        tapGR.numberOfTapsRequired = 1; //单击
        [scrollView addGestureRecognizer:tapGR];
        
        
        _scroll = scrollView;
    }
    return _scroll;
}

-(UIImageView *)logoImg {
    if (!_logoImg) {
        UIImage *image = [UIImage imageNamed:@"logo"];
        UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
        _logoImg = imageV;
    }
    return _logoImg;
}

-(UIButton *)accountBtn {
    if (!_accountBtn) {
        UIButton * accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [accountBtn setTitle:@"账号登陆" forState:UIControlStateNormal];
        [accountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [accountBtn addTarget:self action:@selector(accountBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _accountBtn = accountBtn;
    }
    return _accountBtn;
}

-(UIButton *)fastLand {
    if (!_fastLand) {
        UIButton * fastLand = [UIButton buttonWithType:UIButtonTypeCustom];
        [fastLand setTitle:@"快速登录" forState:UIControlStateNormal];
        [fastLand setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        fastLand.titleLabel.textAlignment = NSTextAlignmentCenter;
        [fastLand setBackgroundColor:[UIColor clearColor]];
        [fastLand addTarget:self action:@selector(fastLandClick) forControlEvents:UIControlEventTouchUpInside];
        _fastLand = fastLand;
    }
    return _fastLand;
}


-(UITextField *)phoneField {
    if (!_phoneField) {
        UITextField *  phoneField = [[UITextField alloc] init];
        phoneField.placeholder = @" 请输入您的用户名";
        phoneField.font = [UIFont systemFontOfSize:14];
        phoneField.delegate = self;
        UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        phoneLabel.text = @"用户名";
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneField.leftView = phoneLabel;
        phoneField.leftViewMode = UITextFieldViewModeAlways;
        phoneField.clearButtonMode = UITextFieldViewModeAlways;
        phoneField.keyboardType = UIKeyboardTypeDefault;
        _phoneField = phoneField;
    }
    return _phoneField;
}

-(UITextField *)passwordField {
    if (!_passwordField) {
        UITextField *  passwordField = [[UITextField alloc] init];
        passwordField.placeholder = @" 请输入密码";
        passwordField.font = [UIFont systemFontOfSize:14];
        passwordField.secureTextEntry = YES;
        passwordField.delegate = self;
        UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        passwordLabel.text = @"密   码";
        passwordLabel.textAlignment = NSTextAlignmentCenter;
        passwordField.leftView = passwordLabel;
        passwordField.leftViewMode = UITextFieldViewModeAlways;
        passwordField.clearButtonMode = UITextFieldViewModeAlways;
        _passwordField = passwordField;
    }
    return _passwordField;
}

-(UIButton *)landBtn {
    if (!_landBtn) {
        UIButton * landBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        landBtn.layer.cornerRadius = 5;
        landBtn.clipsToBounds = YES;
        [landBtn setTitle:@"登陆" forState:UIControlStateNormal];
//        landBtn.backgroundColor = [UIColor colorWithRed:40/255.0f green:158/255.0f blue:239/255.0f alpha:1.0f];
        [landBtn setBackgroundImage:[UIImage imageNamed:@"dlan"] forState:UIControlStateNormal];
        [landBtn addTarget:self action:@selector(landBtnClick) forControlEvents:UIControlEventTouchUpInside];
        landBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _landBtn = landBtn;
    }
    return _landBtn;
}

-(UILabel *)moveLine {
    if (!_moveLine) {
        _moveLine = [[UILabel alloc]init];
        _moveLine.backgroundColor = [UIColor blueColor];
    }
    return _moveLine;
}

-(UITextField *)phoneNum {
    if (!_phoneNum) {
        UITextField *  phoneField = [[UITextField alloc] init];
        phoneField.placeholder = @" 请输入您的手机号";
        phoneField.font = [UIFont systemFontOfSize:14];
        phoneField.delegate = self;
        UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        phoneLabel.text = @"手机号";
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneField.leftView = phoneLabel;
        phoneField.leftViewMode = UITextFieldViewModeAlways;
        phoneField.clearButtonMode = UITextFieldViewModeAlways;
        phoneField.keyboardType = UIKeyboardTypeNumberPad;
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button setTitle:@"发送短信验证码" forState:UIControlStateNormal];
        button.tag = 10;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button addTarget:self action:@selector(sendVerifyCodeClick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor colorWithRed:117.0/255.0f green:203.0/255.0f blue:60.0/255.0f alpha:1.0f];
        [button setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        phoneField.rightView = button;
        phoneField.rightViewMode = UITextFieldViewModeAlways;
        
        _phoneNum = phoneField;
    }
    return _phoneNum;
}

-(UITextField *)verifyCode {
    if (!_verifyCode) {
        
        UITextField *  passwordField = [[UITextField alloc] init];
        passwordField.placeholder = @" 请输入验证码";
        passwordField.font = [UIFont systemFontOfSize:14];
        passwordField.secureTextEntry = YES;
        passwordField.delegate = self;
        UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        passwordLabel.text = @"验证码";
        passwordLabel.textAlignment = NSTextAlignmentCenter;
        passwordField.leftView = passwordLabel;
        passwordField.leftViewMode = UITextFieldViewModeAlways;
        passwordField.clearButtonMode = UITextFieldViewModeAlways;
        

        _verifyCode = passwordField;
        
    }
    return _verifyCode;
}

// 注册界面










#pragma mark -- 获取验证码
-(void)sendVerifyCodeClick:(UIButton *)sender {
    if (sender.tag == 10) {
        UIButton * passwordBtn = (UIButton *)_phoneNum.rightView;
        passwordBtn.backgroundColor = [UIColor colorWithRed:117.0/255.0f green:203.0/255.0f blue:60.0/255.0f alpha:1.0f];
        [passwordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [passwordBtn setTitle:@"(60s)后再获取" forState:UIControlStateNormal];
        passwordBtn.userInteractionEnabled = NO;
        [_timer setFireDate:[NSDate distantPast]];
        _isLoginVerify = YES;
    }else if (sender.tag == 11) {
        UIButton * passwordBtn = (UIButton *)_verify.rightView;
        passwordBtn.backgroundColor = [UIColor colorWithRed:117.0/255.0f green:203.0/255.0f blue:60.0/255.0f alpha:1.0f];
        [passwordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [passwordBtn setTitle:@"(60s)后再获取" forState:UIControlStateNormal];
        passwordBtn.userInteractionEnabled = NO;
        [_timer setFireDate:[NSDate distantPast]];
        _isLoginVerify = NO;
    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;

    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1 target:self selector:@selector(countdown) userInfo: nil repeats:YES];
    [_timer setFireDate:[NSDate  distantFuture]];
    
}
- (void)setupUI{
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dlbj"]];
    imageV.frame = self.view.bounds;
    [self.view addSubview:imageV];
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor clearColor]];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _loginBtn = loginBtn;
    [self.view addSubview:_loginBtn];
    
    UIImage *image = [UIImage imageNamed:@"logo"];
    CGFloat leftMargin = (kScreenWidth-image.size.width)/2.0;
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.left.equalTo(self.view.mas_left).offset(leftMargin*2/3.0);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@50);
    }];
    
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:[UIColor clearColor]];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _registerBtn = registerBtn;
    [self.view addSubview:_registerBtn];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_top);
        make.right.equalTo(self.view.mas_right).offset(-leftMargin/3.0*2);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@50);
    }];
    
    _moveLab = [[UILabel alloc]init];
    _moveLab.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_moveLab];
    
    [_moveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom);
        make.centerX.equalTo(_loginBtn);
        make.width.mas_equalTo(_loginBtn);
        make.height.mas_equalTo(@2);
    }];
    
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.scroll addSubview:self.logoImg];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scroll.mas_left).offset(leftMargin);
        make.top.equalTo(self.scroll.mas_top).offset(20);
        make.width.mas_equalTo(kScreenWidth-2*leftMargin);
        make.height.mas_equalTo(image.size.height);
    }];
    
   
    [self.scroll addSubview:self.accountBtn];
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImg.mas_bottom).offset(20);
        make.left.equalTo(self.scroll.mas_left).offset(leftMargin/2.0);
        make.width.mas_equalTo(@(self.logoImg.frame.size.width/2.0));
        make.height.mas_equalTo(@40);
    }];
    
    [self.scroll addSubview:self.fastLand];
    [self.fastLand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImg.mas_bottom).offset(20);
        make.right.mas_equalTo(self.scroll.mas_left).offset(kScreenWidth-leftMargin/2.0);
        make.width.mas_equalTo(self.logoImg.frame.size.width/2.0);
        make.height.mas_equalTo(40);
    }];
    
    [self.scroll addSubview:self.moveLine];
    [self.moveLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountBtn.mas_bottom);
        make.left.equalTo(self.accountBtn);
        make.width.mas_equalTo(self.accountBtn);
        make.height.mas_equalTo(@2);
    }];
    
   
    [self.scroll addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountBtn.mas_bottom).offset(20);
        make.left.equalTo(self.scroll).offset(leftMargin/3.0);
        make.right.equalTo(self.scroll.mas_left).offset(kScreenWidth-leftMargin/3.0);
        make.height.mas_equalTo(@30);
    }];
    
    [self.scroll addSubview:self.phoneNum];
    self.phoneNum.alpha = 0;
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountBtn.mas_bottom).offset(20);
        make.left.equalTo(self.scroll).offset(leftMargin/3.0);
        make.right.equalTo(self.scroll.mas_left).offset(kScreenWidth-leftMargin/3.0);
        make.height.mas_equalTo(@30);
    }];
    
    [self.scroll addSubview:self.verifyCode];
    self.verifyCode.alpha = 0;
    [self.verifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneField.mas_bottom).offset(20);
        make.left.equalTo(self.phoneField);
        make.right.equalTo(self.phoneField);
        make.height.mas_equalTo(@30);
    }];
    
    
    
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = Font_Week_Color;
    [self.scroll addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneField.mas_bottom);
        make.left.equalTo(self.phoneField);
        make.right.equalTo(self.phoneField);
        make.height.mas_equalTo(@0.5);
    }];
    
    [self.scroll addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneField.mas_bottom).offset(20);
        make.left.equalTo(self.phoneField);
        make.right.equalTo(self.phoneField);
        make.height.mas_equalTo(@30);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = Font_Week_Color;
    [self.scroll addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordField.mas_bottom);
        make.left.equalTo(self.passwordField);
        make.right.equalTo(self.passwordField);
        make.height.mas_equalTo(@0.5);
    }];
    
    [self.scroll addSubview:self.landBtn];
    [self.landBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordField.mas_bottom).offset(40);
        make.left.equalTo(self.passwordField);
        make.right.equalTo(self.passwordField);
        make.height.mas_equalTo(@40);
    }];

    // 注册界面
    NSArray *arr = @[@"手机号",@"验证码",@"昵称",@"密码"];
    for (int i = 0; i < arr.count; i++) {
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth+leftMargin/3.0, 40+70*i, kScreenWidth-leftMargin/3.0*2, 30)];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth+leftMargin/3.0, 70*i+71, kScreenWidth-leftMargin/3.0*2, 0.5)];
        line.backgroundColor = Font_Week_Color;
        [self.scroll addSubview:line];
        
        textField.font = [UIFont systemFontOfSize:14];
        textField.delegate = self;
        UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        phoneLabel.text = arr[i];
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        textField.leftView = phoneLabel;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.keyboardType = UIKeyboardTypeDefault;
        [textField setEnabled:YES];
        textField.userInteractionEnabled = YES;
        
        if (i == 0) {
            textField.placeholder = @" 请输入您的手机号";
            textField.keyboardType = UIKeyboardTypeNumberPad;
            _phone = textField;
        }else if (i == 1) {
            textField.placeholder = @" 请输入验证码";
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            [button setTitle:@"获取验证码" forState:UIControlStateNormal];
            button.tag = 11;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            [button addTarget:self action:@selector(sendVerifyCodeClick:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor colorWithRed:117.0/255.0f green:203.0/255.0f blue:60.0/255.0f alpha:1.0f];
            [button setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
            textField.rightView = button;
            textField.rightViewMode = UITextFieldViewModeAlways;
            
            _verify = textField;
            
        }else if (i == 2) {
            textField.placeholder = @" 请输入昵称";
            _nickname = textField;
            
        }else {
            textField.placeholder = @" 请输入密码";
            textField.secureTextEntry = YES;
            _password = textField;
            
        }
        [self.scroll addSubview:textField];

    }
    UIButton *signUp = [UIButton buttonWithType:UIButtonTypeCustom];
    signUp.layer.cornerRadius = 5;
    signUp.clipsToBounds = YES;
    [signUp setTitle:@"注册" forState:UIControlStateNormal];
    [signUp setBackgroundImage:[UIImage imageNamed:@"dlan"] forState:UIControlStateNormal];
    [signUp addTarget:self action:@selector(signUpClick) forControlEvents:UIControlEventTouchUpInside];
    signUp.titleLabel.textAlignment = NSTextAlignmentCenter;
    _signUp = signUp;
    [self.scroll addSubview:_signUp];
    [_signUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_password.mas_bottom).offset(100);
        make.left.equalTo(_password);
        make.right.equalTo(_password);
        make.height.mas_equalTo(@40);
        
    }];
    
    UILabel * label = [[UILabel alloc] init];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"注册即代表您同意《健身...用户协议》"];
    label.textColor = Font_Week_Color;
    label.adjustsFontSizeToFitWidth = YES;
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(8,str.length-8)];
    label.attributedText = str;
    [self.scroll addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_signUp.mas_bottom).offset(10);
        make.centerX.equalTo(_signUp);
        make.width.mas_equalTo(kScreenWidth/2.0);
        make.height.mas_equalTo(@10);
        
    }];
    
}


#pragma mark -- 手势
-(void)TapClick:(UITapGestureRecognizer *)tap {
    
    [_phoneField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_phoneNum resignFirstResponder];
    [_verifyCode resignFirstResponder];
    
    [_phone resignFirstResponder];
    [_verify resignFirstResponder];
    [_nickname resignFirstResponder];
    [_password resignFirstResponder];
}


#pragma mark -- 倒计时
//倒计时
- (void)countdown {
    
    if (_isLoginVerify) {
        UIButton * passwordBtn = (UIButton *)_phoneNum.rightView;
        static  int i = 60;
        [passwordBtn setTitle:[NSString stringWithFormat:@"(%d)后再获取",i--] forState:UIControlStateNormal];
        if (i == -1) {
            [_timer  setFireDate:[NSDate distantFuture]];
            passwordBtn.userInteractionEnabled = YES;
            i = 60;
            [passwordBtn setTitle:@"(60s)后再获取" forState:UIControlStateNormal];
        }
    }else {
        UIButton * verifyBtn = (UIButton *)_verify.rightView;
        static  int n = 60;
        [verifyBtn setTitle:[NSString stringWithFormat:@"(%d)后再获取",n--] forState:UIControlStateNormal];
        if (n == -1) {
            [_timer  setFireDate:[NSDate distantFuture]];
            verifyBtn.userInteractionEnabled = YES;
            n = 60;
            [verifyBtn setTitle:@"(60s)后再获取" forState:UIControlStateNormal];
        }
    }
    
}




#pragma mark -- 键盘
-(void)keyboardWillShow:(NSNotification *)note {
    
    CGRect keyBoardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyBoardRect.size.height;
    
    float textY ;
    CGFloat bottomY = self.view.frame.size.height;
    
    if(_phoneField.isEditing) {
        textY = bottomY - _passwordField.frame.origin.y-10;
    }else if (_passwordField.isEditing || _verifyCode.isEditing) {
        textY = bottomY-_passwordField.frame.origin.y-80;
    }else if (_phoneNum.isEditing) {
        textY = bottomY-_phoneNum.frame.origin.y-100;
    }else if (_phone.isEditing) {   // 以下是注册
        textY = bottomY-_phone.frame.origin.y-10;
    }else if (_verify.isEditing) {
        textY = bottomY-_verify.frame.origin.y-10;
    }else if (_nickname.isEditing) {
        textY = bottomY-_nickname.frame.origin.y-10;
    }else if (_password.isEditing) {
        textY = bottomY-_password.frame.origin.y-10;
    }
    
    if (textY >= keyboardH) {
        return;
    }
    
    CGFloat moveHeight = keyboardH-textY+60;  // 要移动的距离
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.scroll mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.mas_bottom).offset(-moveHeight);
        }];
        
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)note {
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.scroll mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.mas_bottom).offset(1);
        }];
        
    }];
}



#pragma mark -- 代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"])//按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (textField == _phoneNum || textField == _phone) {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"温馨提示"                                                                             message:@"输入的手机号码位数超过了11位"                                                                       preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [_phoneNum resignFirstResponder];
            }]];
            [self presentViewController: alertController animated: YES completion: nil];
        }

    }
    
    return YES;
}



#pragma mark --- Events Handel

-(void)loginBtnClick {
    // 最上面登录
    [UIView animateWithDuration:0.6 animations:^{
       [_moveLab mas_updateConstraints:^(MASConstraintMaker *make) {
           make.centerX.equalTo(_loginBtn);
       }];
    }];
    self.scroll.contentOffset = CGPointMake(0, 0);
}

-(void)registerBtnClick {
    // 注册按钮
    [UIView animateWithDuration:0.5 animations:^{
        [_moveLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_loginBtn).offset(_registerBtn.frame.origin.x-_loginBtn.frame.origin.x);
        }];
    }];
    
    self.scroll.contentOffset = CGPointMake(kScreenWidth, 0);
}



// 账号密码登录
- (void)accountBtnClick{
    
    self.phoneNum.alpha = 0;
    self.verifyCode.alpha = 0;
    self.phoneField.alpha = 1;
    self.passwordField.alpha = 1;
    
    [UIView animateWithDuration:0.3 animations:^{
       [self.moveLine mas_updateConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.accountBtn);
       }];
    }];
}

//  快速登录
- (void)fastLandClick{
    
    self.phoneField.alpha = 0;
    self.passwordField.alpha = 0;
    self.phoneNum.alpha = 1;
    self.verifyCode.alpha = 1;
    
    [UIView animateWithDuration:0.3 animations:^{
       
        [self.moveLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.accountBtn).offset(self.fastLand.frame.origin.x-self.accountBtn.frame.origin.x);
        }];
        
    }];
    
}

// 最下面登录按钮
- (void)landBtnClick{
    
    imUserName = @"visitor2";
    imPassword = @"taobao1234";
    
    // 跳到主界面
    
    [[NSUserDefaults standardUserDefaults] setObject:@"firstLogin" forKey:isLogin];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// 最下面注册
-(void)signUpClick {
    
    [CYProgressHUD showMessage:@"休息一下♨️" andAutoHideAfterTime:1];
    
}


#pragma mark -- scrollerView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x > kScreenWidth/2.0) {
        [UIView animateWithDuration:0.5 animations:^{
            [_moveLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_loginBtn).offset(_registerBtn.frame.origin.x-_loginBtn.frame.origin.x);
            }];
        }];
    }else if (scrollView.contentOffset.x < kScreenWidth/2.0) {
        [UIView animateWithDuration:0.6 animations:^{
            [_moveLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_loginBtn);
            }];
        }];
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [_phoneField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_phoneNum resignFirstResponder];
    [_verifyCode resignFirstResponder];
    
    [_phone resignFirstResponder];
    [_verify resignFirstResponder];
    [_nickname resignFirstResponder];
    [_password resignFirstResponder];

    
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
