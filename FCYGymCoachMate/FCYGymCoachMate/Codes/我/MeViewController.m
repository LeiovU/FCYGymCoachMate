//
//  MeViewController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/3.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "MeViewController.h"
#import "SettingViewController.h"

@interface MeViewController ()

@property (nonatomic,strong)UIView *contentView;

@property (nonatomic,strong) UIImageView *iconView;  // 头像
@property (nonatomic,strong) UILabel *nameLabel; // 名字
@property (nonatomic,strong) UILabel *phoneNum;  // 电话
@property (nonatomic,strong) UILabel *weixinNick;  // 微信绑定


#define Text_Color [@"#666666" colorValue]

@end

@implementation MeViewController


#pragma mark -- 懒加载
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:self.view.bounds];
        _contentView.backgroundColor = Back_Color;
        
    }
    return _contentView;
}

-(UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.frame = CGRectMake((kScreenWidth-Icon_Radius)/2, (225-64)/3, Icon_Radius, Icon_Radius);
//        _iconView.layer.cornerRadius = Icon_Radius/2;
//        _iconView.clipsToBounds = YES;
//        _iconView.backgroundColor = [UIColor yellowColor];
        _iconView.image = [UIImage imageNamed:@"pic"];
    }
    return _iconView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.frame = CGRectMake((kScreenWidth-Icon_Radius)/2, (561-107-64)/3, Icon_Radius, 107/3);
        _nameLabel.text = @"我是谁";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

-(UILabel *)phoneNum {
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2.0, 0, kScreenWidth/2.0-20/3, 149/3)];
        _phoneNum.textColor = Text_Color;
        _phoneNum.text = @"189XXX";
        _phoneNum.font = [UIFont fontWithName:Font_Name size:18];
        _phoneNum.textAlignment = NSTextAlignmentRight;
    }
    return _phoneNum;
}

-(UILabel *)weixinNick {
    if (!_weixinNick) {
        _weixinNick = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2.0, 0, kScreenWidth/2.0-20/3, 149/3)];
        _weixinNick.textColor = Text_Color;
        _weixinNick.text = @"XXX";
        _weixinNick.font = [UIFont fontWithName:Font_Name size:18];
        _weixinNick.textAlignment = NSTextAlignmentRight;
    }
    return _weixinNick;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的";
    
    [self prepareDataSource];
    
    [self setupSubViews];
    
}

-(void)prepareDataSource {
    
}

-(void)setupSubViews {
    [self.view addSubview:self.contentView];
    
    CGFloat height = (561-64)/3;
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    backView1.backgroundColor = Nav_Color;
    [self.contentView addSubview:backView1];
    
    [backView1 addSubview:self.iconView];
    [backView1 addSubview:self.nameLabel];
    
    
    CGFloat marginY = backView1.frame.size.height+20/3;
    CGFloat marginX = 46/3;
    CGFloat height1 = 149/3;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, marginY, kScreenWidth, height1)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view1];
    
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(marginX, height1/4, height1/2, height1/2)];
    imageV1.image = [UIImage imageNamed:@"call"];
    [view1 addSubview:imageV1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageV1.frame.size.width+marginX+10, height1/4, height1*2, height1/2)];
    label.text = @"手机号码";
    label.textColor = [@"#333333" colorValue];
    label.font = [UIFont fontWithName:Font_Name size:18];
    [view1 addSubview:label];
    
    [view1 addSubview:self.phoneNum];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, marginY+height1+1, kScreenWidth, height1)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view2];
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(marginX, height1/4, height1/2, height1/2)];
    imageV2.image = [UIImage imageNamed:@"weix"];
    [view2 addSubview:imageV2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(imageV1.frame.size.width+marginX+10, height1/4, height1*2, height1/2)];
    label2.text = @"微信绑定";
    label2.textColor = [@"#333333" colorValue];
    label2.font = [UIFont fontWithName:Font_Name size:18];
    [view2 addSubview:label2];
    
    [view2 addSubview:self.weixinNick];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, marginY+height1*2+2+20/3, kScreenWidth, height1)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view3];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreenWidth-height1*2)/2, 0, height1*2, height1);
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:Font_Name size:21];
    [btn addTarget:self action:@selector(onBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view3 addSubview:btn];
    
    
}

// 设置按钮
-(void)onBtnClick {
    // 设置
    SettingViewController *setVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
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
