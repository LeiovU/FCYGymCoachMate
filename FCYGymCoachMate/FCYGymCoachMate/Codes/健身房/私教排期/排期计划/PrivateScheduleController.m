//
//  PrivateScheduleController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/6/7.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "PrivateScheduleController.h"
#import "GFCalendarView.h"

@interface PrivateScheduleController () <TouchEnventDelegate> {
    NSInteger _monthRestDay;
}


@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) ZJUsefulPickerView *pickerView;
@property (nonatomic,strong) GFCalendarView *calendarView;  // 日历
@property (nonatomic,strong) UIScrollView *scroll;

@property (nonatomic,strong) UILabel *monthWork;
@property (nonatomic,strong) UILabel *monthRest;
@property (nonatomic,strong) UILabel *monthOrderCourse;
@property (nonatomic,strong) UILabel *monthTeachCourse;



@end


@implementation PrivateScheduleController



#pragma mark -- 懒加载
-(UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.frame = CGRectMake(0, 0, 100, 40);
        [_titleBtn setTitle:@"健身房1" forState:UIControlStateNormal];
        [_titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_titleBtn setBackgroundColor:[UIColor clearColor]];
        _titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_titleBtn setImage:[UIImage imageNamed:@"sj_05"] forState:UIControlStateNormal];
        [_titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [_titleBtn setImageEdgeInsets:UIEdgeInsetsMake(_titleBtn.frame.size.height/4.0*2, 80, 0, 0)];
        [_titleBtn addTarget:self action:@selector(showSelectGym:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _titleBtn;
}

-(GFCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[GFCalendarView alloc]initWithFrameOrigin:CGPointMake(0, 0) width:kScreenWidth];
        //        _calendarView.isShowTopView = NO;
        _calendarView.backgroundColor = [UIColor whiteColor];
        _calendarView.calendarScrollEnabled = NO;
    }
    return _calendarView;
}

-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.calendarView.frame.size.height+self.calendarView.frame.origin.y, kScreenWidth, 200)];
        _scroll.backgroundColor = Back_Color;
        _scroll.scrollEnabled = YES;
        _scroll.showsVerticalScrollIndicator = YES;
        
    }
    return _scroll;
}



#pragma mark -- 跳出健身房选择
-(void)showSelectGym:(UIButton *)sender {
    
    // 旋转
    sender.selected  = !sender.selected;
    sender.imageView.transform = sender.selected ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
    
    // pick view
     self.pickerView = [ZJUsefulPickerView showSingleColPickerWithToolBarText:@"" withData:@[@"健身房1",@"健身房2",@"健身房3"] withDefaultIndex:1 withCancelHandler:^{
        NSLog(@"取消");
        sender.imageView.transform = CGAffineTransformMakeRotation(0);
         sender.selected = NO;
    } withDoneHandler:^(NSInteger selectedIndex, NSString *selectedValue) {
        [_titleBtn setTitle:selectedValue forState:UIControlStateNormal];
        sender.imageView.transform = CGAffineTransformMakeRotation(0);
        sender.selected = NO;
    }];
    self.pickerView.delegate = self;

    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // title view
    self.navigationItem.titleView = self.titleBtn;
    
    [self createNavigationItemsWithTitle:nil andWithImage:[UIImage imageNamed:@"sj_06"] andWithType:NO andWithTag:Private_Schedule_Add];
    [self createNavigationItemsWithTitle:nil andWithImage:[UIImage imageNamed:@"sj_04"] andWithType:YES andWithTag:Private_Schedule_Back];
    
    UIView *back = [[UIView alloc]initWithFrame:self.view.bounds];
    back.backgroundColor = Back_Color;
    [self.view addSubview:back];
    [back addSubview:self.calendarView];
    self.calendarView.didSelectDayHandler = ^(NSInteger year,NSInteger month,NSInteger day,BOOL isClick) {
        NSLog(@"%ld月%ld号",month,day);
    };
    
    // scrollView
    [back addSubview:self.scroll];
    
    // 第一部分
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 49)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:view1];
    
    UIView *circle1 = [[UIView alloc]initWithFrame:CGRectMake(30, 10, 20, 20)];
    circle1.backgroundColor = Font_Color;
    circle1.layer.cornerRadius = 10;
    circle1.clipsToBounds = YES;
    [view1 addSubview:circle1];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"工作日";
    label.textColor = Font_Color;
    label.font = [UIFont systemFontOfSize:13];
    [view1 addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(circle1.mas_right).offset(5);
        make.top.mas_equalTo(circle1.mas_top);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(circle1.mas_height);
    }];
    
    UIView *circle2 = [[UIView alloc]init];
    circle2.backgroundColor = Font_Week_Color;
    circle2.layer.cornerRadius = 10;
    circle2.clipsToBounds = YES;
    [view1 addSubview:circle2];
    [circle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right);
        make.top.mas_equalTo(label.mas_top);
        make.width.mas_equalTo(circle1.mas_width);
        make.height.mas_equalTo(circle1.mas_height);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"休息日";
    label2.textColor = Font_Week_Color;
    label2.font = [UIFont systemFontOfSize:16];
    [view1 addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(circle2.mas_right).offset(5);
        make.top.mas_equalTo(circle2.mas_top);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(circle2.mas_height);
    }];
    
    UIView *circle3 = [[UIView alloc]init];
    circle3.backgroundColor = Font_Red_Color;
    [view1 addSubview:circle3];
    [circle3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label2.mas_right).offset(5);
        make.top.mas_equalTo(label2.mas_top).offset(10);
        make.width.mas_equalTo(circle1.mas_width);
        make.height.mas_equalTo(@2);
    }];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"有约课";
    label3.textColor = Font_Red_Color;
    label3.font = [UIFont systemFontOfSize:16];
    [view1 addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(circle3.mas_right).offset(5);
        make.top.mas_equalTo(circle2.mas_top);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(circle2.mas_height);
    }];
    
    
    // 第二部分
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, view1.frame.size.height+20, kScreenWidth, 90)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:view2];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(10, 10, kScreenWidth/3.0, 20);
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont systemFontOfSize:18];
    lab.textColor = [@"#3abbdc" colorValue];
    lab.text = [NSString stringWithFormat:@"工作日统计"];
    [view2 addSubview:lab];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"sj_09"];
    imageV.contentMode = UIViewContentModeCenter;
    [view2 addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_left).offset(15);
        make.top.mas_equalTo(lab.mas_bottom).offset(10);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
    }];
    
    UILabel *monthLab = [[UILabel alloc]init];
    monthLab.textColor = Font_Mid_Color;
    monthLab.textAlignment = NSTextAlignmentLeft;
    monthLab.font = [UIFont systemFontOfSize:18];
    monthLab.text = @"月工作日:23天";
    self.monthWork = monthLab;
    [view2 addSubview:self.monthWork];
    
    [self.monthWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV.mas_right).offset(20);
        make.top.mas_equalTo(imageV);
        make.width.mas_equalTo(@(kScreenWidth/2.0));
        make.height.mas_equalTo(@20);
    }];
    
    UILabel *monthLabRest = [[UILabel alloc]init];
    monthLabRest.textColor = Font_Mid_Color;
    monthLabRest.textAlignment = NSTextAlignmentLeft;
    monthLabRest.font = [UIFont systemFontOfSize:18];
    monthLabRest.text = [NSString stringWithFormat:@"月休息日:3天"];
    self.monthRest = monthLabRest;
    [view2 addSubview:self.monthRest];
    
    [self.monthRest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.monthWork);
        make.top.mas_equalTo(self.monthWork.mas_bottom);
        make.width.mas_equalTo(self.monthWork.mas_width);
        make.height.mas_equalTo(self.monthWork.mas_height);
    }];
    
    // 第3部分
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height+10, kScreenWidth, 90)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:view3];
    
    UILabel *lab2 = [[UILabel alloc]init];
    lab2.frame = CGRectMake(10, 10, kScreenWidth/3.0, 20);
    lab2.textAlignment = NSTextAlignmentLeft;
    lab2.font = [UIFont systemFontOfSize:18];
    lab2.textColor = [@"#3abbdc" colorValue];
    lab2.text = [NSString stringWithFormat:@"课程统计"];
    [view3 addSubview:lab2];
    
    UIImageView *imageV2 = [[UIImageView alloc]init];
    imageV2.image = [UIImage imageNamed:@"sj_10"];
    imageV2.contentMode = UIViewContentModeCenter;
    [view3 addSubview:imageV2];
    
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab2.mas_left).offset(15);
        make.top.mas_equalTo(lab2.mas_bottom).offset(10);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
    }];
    
    UILabel *orderCourse = [[UILabel alloc]init];
    orderCourse.textColor = Font_Mid_Color;
    orderCourse.textAlignment = NSTextAlignmentLeft;
    orderCourse.font = [UIFont systemFontOfSize:18];
    orderCourse.text = @"本月约课:73节";
    self.monthOrderCourse = orderCourse;
    [view3 addSubview:self.monthOrderCourse];
    
    [self.monthOrderCourse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV2.mas_right).offset(20);
        make.top.mas_equalTo(imageV2);
        make.width.mas_equalTo(@(kScreenWidth/2.0));
        make.height.mas_equalTo(@20);
    }];
    
    UILabel *teachCourse = [[UILabel alloc]init];
    teachCourse.textColor = Font_Mid_Color;
    teachCourse.textAlignment = NSTextAlignmentLeft;
    teachCourse.font = [UIFont systemFontOfSize:18];
    teachCourse.text = [NSString stringWithFormat:@"本月授课:12节"];
    self.monthTeachCourse = teachCourse;
    [view3 addSubview:self.monthTeachCourse];
    
    [self.monthTeachCourse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.monthOrderCourse);
        make.top.mas_equalTo(self.monthOrderCourse.mas_bottom);
        make.width.mas_equalTo(self.monthOrderCourse.mas_width);
        make.height.mas_equalTo(self.monthOrderCourse.mas_height);
    }];


    
    
    _scroll.contentSize = CGSizeMake(kScreenWidth, 320);
    
    
    // Do any additional setup after loading the view.
}

#pragma mark  -- navigation item
-(void)onBarButtonClick:(UIButton *)sender {
    if (sender.tag == [Private_Schedule_Add integerValue]) {
        // 加号事件
        
    }else if (sender.tag == [Private_Schedule_Back integerValue]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- 代理 pickerView
// 为了旋转
-(void)touchEnventChange {
    _titleBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    _titleBtn.selected = NO;
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
