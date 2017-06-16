//
//  ScheduleController.m
//  FCYGymCoachMate
//
//  Created by AsiaInfo on 2017/6/15.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "ScheduleController.h"
#import "ASWeekSelectorView.h"

@interface ScheduleController () <ASWeekSelectorViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIView *backView1;
@property (nonatomic,strong) UIView *backView2;

@property (nonatomic,strong) ASWeekSelectorView *weekClaendar;

@property (nonatomic,strong) UIButton *todayBtn;
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) UIButton *timeBtn;

@end

@implementation ScheduleController

#pragma mark -- 懒加载
-(UIView *)backView1 {
    if (!_backView1) {
        _backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, WeekDay_H)];
        _backView1.backgroundColor = [UIColor whiteColor];
        
    }
    return _backView1;
}
-(UIView *)backView2 {
    if (!_backView2) {
        _backView2 = [[UIView alloc]initWithFrame:CGRectMake(0, WeekDay_H+10, kScreenWidth, 40)];
        _backView2.backgroundColor = [UIColor whiteColor] ;
    }
    return _backView2;
}

-(ASWeekSelectorView *)weekClaendar {
    if (!_weekClaendar) {
        _weekClaendar = [[ASWeekSelectorView alloc]initWithFrame:CGRectMake(kScreenWidth/6.0, 0, kScreenWidth-kScreenWidth/6.0, WeekDay_H)];
        _weekClaendar.firstWeekday = 1;
        _weekClaendar.delegate = self;
        _weekClaendar.selectedDate = [NSDate date];
        _weekClaendar.letterTextColor = [UIColor blackColor];
    }
    return _weekClaendar;
}

-(UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]init];
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.placeholder = @"搜索用户名";
        _searchTextField.font = [UIFont systemFontOfSize:12];
        _searchTextField.textColor = [UIColor lightGrayColor];
        _searchTextField.adjustsFontSizeToFitWidth = YES;
        _searchTextField.keyboardType = UIKeyboardTypeDefault;
        _searchTextField.returnKeyType = UIReturnKeyDone;
        _searchTextField.delegate = self;
        _searchTextField.textAlignment = NSTextAlignmentRight;
    }
    return _searchTextField;
}

-(UIButton *)timeBtn {
    if (!_timeBtn) {
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeBtn setTitle:@"19:00" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:Font_Mid_Color forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_timeBtn addTarget:self action:@selector(selectTimeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeBtn;
}

-(UIButton *)todayBtn {
    if (!_todayBtn) {
        _todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _todayBtn.frame = CGRectMake(0, 0, kScreenWidth/6.0, WeekDay_H);
        [_todayBtn setTitle:@"选择" forState:UIControlStateNormal];
        [_todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_todayBtn setImage:[UIImage imageNamed:@"rl_03"] forState:UIControlStateNormal];
        [_todayBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 12, 30, 10)];
        [_todayBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, -_todayBtn.imageView.frame.size.width-3, 0, 0)];
        [_todayBtn setBackgroundColor:[@"#3d72fe" colorValue]];
    }
    return _todayBtn;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Back_Color;
    
    // 添加子视图
    [self createSubviews];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)createSubviews {
    [self.view addSubview:self.backView1];
    
    [self.backView1 addSubview:self.todayBtn];
    [self.backView1 addSubview:self.weekClaendar];
    
    [self.view addSubview:self.backView2];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4.0, 40)];
    label.text = @" 选择会员";
    label.textColor = Font_Mid_Color;
    [self.backView2 addSubview:label];
    
    [_backView2 addSubview:self.searchTextField];
    CGFloat width = kScreenWidth/3.0;
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView2.mas_top);
        make.right.mas_equalTo(self.backView2.mas_right).offset(-30);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(self.backView2.mas_height);
    }];
    
    UIView *backView3 = [[UIView alloc]init];
    backView3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView3];
    
    [backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView2.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(self.backView2.mas_width);
        make.height.mas_equalTo(self.backView2.mas_height);
    }];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4.0, 40)];
    label2.text = @" 预约时间";
    label2.textColor = Font_Mid_Color;
    [backView3 addSubview:label2];
    
    [backView3 addSubview:self.timeBtn];
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView3.mas_top);
        make.right.mas_equalTo(backView3.mas_right);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(backView3.mas_height);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[@"#d4d9e4" colorValue]];
    button.tag = 10;
    [button addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kScreenWidth/2.0);
        make.height.mas_equalTo(60);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"确认预约" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 setBackgroundColor:[@"#3d72fe" colorValue]];
    button1.tag = 11;
    [button1 addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(kScreenWidth/2.0);
        make.width.mas_equalTo(kScreenWidth/2.0);
        make.height.mas_equalTo(60);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
}


#pragma mark -- 取消或确定预约
-(void)onBtnClick:(UIButton *)sender {
    if (sender.tag == 10) {
        // 取消
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        // 确定预约
        
    }
}


#pragma mark -- 预约时间
-(void)selectTimeClick {
    //  弹出选择框
    
    
}

#pragma mark -- textField 代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_searchTextField resignFirstResponder];
    return YES;
}


//触屏－可回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    for (UITextField *textField in self.view.subviews) {
//        if ([textField isKindOfClass:[UITextField class]]) {
//            [textField resignFirstResponder];
//        }
//    }
    [_searchTextField resignFirstResponder];
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
