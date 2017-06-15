//
//  GymViewController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/3.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "GymViewController.h"

#import "UIButton+SetImgAndTitle.h"

#import "MemberDetailsController.h"
#import "PrivatePlanController.h"
#import "MeViewController.h"

#import "CYTabBarController.h"
#import "PlusAnimate.h"
#import "CYBadgeView.h"


@interface GymViewController () <CYTabBarDelegate,PublishAnimateDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *gymName;  // 健身房名字
@property (nonatomic,strong) UILabel *stadiumName; // 场馆名字
@property (nonatomic,strong) UIImageView *stadiumPic; // 场馆logo

@property (nonatomic,strong) UIImageView *iconView;  // 头像
@property (nonatomic,strong) UILabel *briefIntroduce;  // 简介
@property (nonatomic,strong) UILabel *gymAddress;   //地址

@property (nonatomic,strong) CYBadgeView * badgeView;   // 小角标

#define SCALE 377/360.0

@end

@implementation GymViewController

#pragma mark -- 懒加载
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
        scrollView.backgroundColor = [UIColor clearColor];
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [@"#e6e6e6" colorValue];
    }
    return _contentView;
}

-(UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
//        _iconView.layer.cornerRadius = Icon_Radius/2;
//        _iconView.clipsToBounds = YES;
//        _iconView.backgroundColor = [UIColor yellowColor];
        _iconView.image = [UIImage imageNamed:@"pic"];
    }
    return _iconView;
}

-(UILabel *)briefIntroduce {
    if (!_briefIntroduce) {
        _briefIntroduce = [[UILabel alloc]init];
        _briefIntroduce.textColor = [UIColor whiteColor];
        _briefIntroduce.font = [UIFont fontWithName:@"微软雅黑" size:22];
        _briefIntroduce.text = @"XXX工作室";
        _briefIntroduce.textAlignment = NSTextAlignmentLeft;
    }
    return _briefIntroduce;
}

-(UILabel *)gymAddress {
    if (!_gymAddress) {
        _gymAddress = [[UILabel alloc]init];
        _gymAddress.textColor = [UIColor whiteColor];
        _gymAddress.font = [UIFont fontWithName:@"微软雅黑" size:18];
        _gymAddress.text = @"地址：XXX";
        _gymAddress.textAlignment = NSTextAlignmentLeft;
    }
    return _gymAddress;
}

-(CYBadgeView *)badgeView {
    if (!_badgeView) {
        _badgeView = [[CYBadgeView alloc]init];
        _badgeView.badgeValue = @"12";
        _badgeView.badgeColor = [UIColor orangeColor];
    }
    return _badgeView;
}



-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-60-64);
    self.scrollView.contentSize = CGSizeMake(0, kScreenHeight-64-60);
    CGFloat marginY = (235-64)/3;
    self.iconView.frame = CGRectMake(25, marginY, Icon_Radius, Icon_Radius);
    
    CGFloat marginX = self.iconView.frame.size.width+25+15;
    CGFloat width = kScreenWidth-self.iconView.frame.size.width-25-10;
    self.briefIntroduce.frame = CGRectMake(marginX, 50, width, 40);
    self.gymAddress.frame = CGRectMake(marginX, 50+40+10, width, 30);
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    // 去除导航栏下的分割线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    
    // 添加标题title view
    [self addTitleView];
    [self setupSubviews];
    
    // 设置自定义tabbar代理
    CYTABBARCONTROLLER.tabbar.delegate = self;
    
    
    
}

// title view
-(void)addTitleView {
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = titleView.frame;
    label.text = @"健身馆";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    
    [titleView addSubview:label];
    
    self.navigationItem.titleView = titleView;
}


-(void)setupSubviews {
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    CGFloat backHeight = (561-64)/3;
    // 背景1
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, backHeight)];
    backView1.backgroundColor = Nav_Color;
    [self.contentView addSubview:backView1];
    
    [backView1 addSubview:self.iconView];
    [backView1 addSubview:self.briefIntroduce];
    [backView1 addSubview:self.gymAddress];
    
    UIView *backView2 = [[UIView alloc]initWithFrame:CGRectMake(0, backHeight+2, kScreenWidth, backHeight*4)];
    backView2.backgroundColor = [@"#f2f2f2" colorValue];
    [self.contentView addSubview:backView2];
    
    
    // 添加【私教排期、会员、消息提醒、课程报表、我的】按钮
    
    // 添加小角标
    CGRect rect = CGRectMake(0, 0, kScreenWidth/3.0, kScreenWidth/3.0);
    CGFloat pointX = rect.size.width/4.0*3;
    UIView *badgeBack = [[UIView alloc]initWithFrame:self.badgeView.frame];
    [badgeBack addSubview:self.badgeView];
    badgeBack.center = CGPointMake(pointX, 0);
    
    CGFloat widthA = kScreenWidth/3.0;
    NSArray *kindsName = @[@"私教排期",@"会员",@"消息提醒",@"课程报表",@"我的"];
    for (int i = 0; i<kindsName.count; i++) {
        CGRect rectA = CGRectMake(widthA*(i%3), SCALE*widthA*(i/3), widthA, SCALE*widthA);
        UIView *titleImgView = [self createClickImage:[NSString stringWithFormat:@"icon_0%d",i+1] title:kindsName[i] frame:rectA tag:i+1];
        if (i == 2) {
            [titleImgView addSubview:badgeBack];
        }
        [backView2 addSubview:titleImgView];
    }
    
    
    UIView *backView3 = [[UIView alloc]initWithFrame:CGRectMake(0, backHeight*5+4, kScreenWidth, backHeight*3)];
    backView3.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView3];
    
}

#pragma  mark -- 自定制下部带标题，图片带点击的imageView
-(UIView *)createClickImage:(NSString *)imageStr title:(NSString *)title frame:(CGRect)frame tag:(NSInteger)tag {
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [UIImage imageNamed:imageStr];
    CGFloat marginL = (frame.size.width-image.size.width)/2.0;
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(marginL, 10, imageW, imageH)];
    imageV.backgroundColor = [UIColor clearColor];
    imageV.image = image;
    [view addSubview:imageV];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectZero;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [@"#333333" colorValue];
    
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.right.equalTo(view.mas_right);
        make.top.equalTo(imageV.mas_bottom).offset(15);
        make.bottom.equalTo(view.mas_bottom).offset(-26);
    }];
    
    // 添加透明btn
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    button.tag = tag;
    [button addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

#pragma mark -- 按钮点击事件
-(void)onClickBtn:(UIButton *)sender {
    if (sender.tag == 1) {
        // 私教排期
        PrivatePlanController *planVC = [[PrivatePlanController alloc]init];
        [self.navigationController pushViewController:planVC animated:YES];
        
    }else if (sender.tag == 2) {
        //会员
        MemberDetailsController *memberVC = [[MemberDetailsController alloc]init];
        
        [self.navigationController pushViewController:memberVC animated:YES];
        
    }else if (sender.tag == 3) {
        // 消息
        
        
        // 移除角标
        [self.badgeView removeFromSuperview];
    }else if (sender.tag == 4) {
        // 课程报表
        
    }else {
        // 我的
        MeViewController *mineVC = [[MeViewController alloc]init];
        [self.navigationController pushViewController:mineVC animated:YES];
    }
}




#pragma mark -- CYTabBarDelegate
// 中间按钮点击事件
-(void)tabbar:(CYTabBar *)tabbar clickForCenterButton:(CYCenterButton *)centerButton {
    PlusAnimate *plusAnimate = [PlusAnimate standardPublishAnimateWithView:centerButton];
    plusAnimate.delegate = self;
}

#pragma mark -- animate 代理
-(void)didSelectBtnWithBtnTag:(NSInteger)tag {
    if (tag == 0) {
        NSLog(@"代约私教");
        [CYProgressHUD showMessage:@"哪位好心人" andAutoHideAfterTime:1.5];
    }else if (tag == 1) {
        NSLog(@"设置排期");
    }else {
        NSLog(@"新增休息");
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
