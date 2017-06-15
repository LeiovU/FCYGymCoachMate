//
//  CourseViewController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/3.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */

#import "CourseViewController.h"
#import "ChoseGymController.h"

#import "GFCalendarView.h"
#import "NSDate+GFCalendar.h"
#import "ASWeekSelectorView.h"

#import "SlideFormScrollView.h"
#import "HomePagesController.h"

#import "CoursePlanController.h"  // 课程安排
#import "AddScheduleController.h" // 添加排期

@interface CourseViewController () <ASWeekSelectorViewDelegate>
{
    UIButton *titleBtn;
    UIButton *dateBtn;
    
    NSDate  *monthDate;
    BOOL    isShowCalendar;
    CGRect  calendarRect;
    
}

@property (nonatomic,strong) GFCalendarView *calendarView;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *backView2;

@property (nonatomic,strong) ASWeekSelectorView *weekClaendar;

@property (nonatomic,strong) SlideFormScrollView *scrollerView;

@end



@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 标题
    [self addTitleView];
    
    // 左边按钮
    [self createNavigationItemsWithTitle:@"我的主页" andWithImage:nil andWithType:YES andWithTag:HomePage_Tag];
    
    // 添加子试图
    [self addSubviews];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skipTo:) name:@"skipTo" object:nil];
   
    
    // Do any additional setup after loading the view.
}

#pragma mark -- 通知
-(void)skipTo:(NSNotification *)sender {
    NSNumber *numberX = [[NSUserDefaults standardUserDefaults] objectForKey:@"touchPointX"];
    NSNumber *numberY = [[NSUserDefaults standardUserDefaults] objectForKey:@"touchPointY"];
    CGPoint point = CGPointMake([numberX floatValue], [numberY floatValue]);
    
    NSLog(@"(%f,%f)",point.x,point.y);
    
    //  在跳转之前根据point，去找出
    
    if (point.x > kScreenWidth/8.0*3) {
        AddScheduleController *addSchedule = [[AddScheduleController alloc]init];
        [self.navigationController pushViewController:addSchedule animated:YES];
    }else {
        // 跳到 课程安排界面
        CoursePlanController *coursePlan = [[CoursePlanController alloc]init];
        [self.navigationController pushViewController:coursePlan animated:YES];

    }
    
    
    
}

#pragma mark -- 重写按钮点击事件
-(void)onBarButtonClick:(UIButton *)sender {
    if (sender.tag == [HomePage_Tag integerValue]) {
        // 跳到主页
        HomePagesController *homeVC = [[HomePagesController alloc]init];
        
        
        [self.view.window setTransitionAnimationType:FCYTransitionAnimationTypeOglFlip toward:FCYTransitionAnimationTowardFromLeft duration:0.5];
        
        [self.navigationController pushViewController:homeVC animated:YES];
    }
}

#pragma mark -- 懒加载
-(GFCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[GFCalendarView alloc]initWithFrameOrigin:CGPointMake(0, 0) width:kScreenWidth];
//        _calendarView.isShowTopView = NO;
        calendarRect = _calendarView.frame;
        _calendarView.backgroundColor = [UIColor whiteColor];
    }
    return _calendarView;
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 104, kScreenWidth, kScreenHeight)];
        _backView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
        
    }
    return _backView;
}
-(UIView *)backView2 {
    if (!_backView2) {
        _backView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 124, kScreenWidth, WeekDay_H)];
        _backView2.backgroundColor = [UIColor whiteColor] ;
    }
    return _backView2;
}

-(ASWeekSelectorView *)weekClaendar {
    if (!_weekClaendar) {
        _weekClaendar = [[ASWeekSelectorView alloc]initWithFrame:CGRectMake(kScreenWidth/8.0, 0, kScreenWidth-kScreenWidth/8.0, WeekDay_H)];
        _weekClaendar.firstWeekday = 1;
        _weekClaendar.delegate = self;
        _weekClaendar.selectedDate = [NSDate date];
        _weekClaendar.letterTextColor = [UIColor lightGrayColor];
    }
    return _weekClaendar;
}

-(SlideFormScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = [[SlideFormScrollView alloc]initWithFrame:CGRectMake(0, 180, kScreenWidth, kScreenHeight-180-49)];
    }
    return _scrollerView;
}


#pragma mark -- 标题 view
-(void)addTitleView {
     UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleView.backgroundColor = [UIColor clearColor];
    
    titleBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(0, 0, 100, 40);
    [titleBtn setTitle:@"全部课程" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [titleBtn setBackgroundColor:[UIColor clearColor]];
    [titleBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 30)];
    [titleBtn addTarget:self action:@selector(choseGymClick) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [titleView addSubview:titleBtn];
    
    self.navigationItem.titleView = titleView;
    
}

#pragma mark -- 标题按钮事件
-(void)choseGymClick {
    
    [ZJUsefulPickerView showSingleColPickerWithToolBarText:@"" withData:@[@"健身房1",@"健身房2",@"健身房3"] withDefaultIndex:1 withCancelHandler:^{
        NSLog(@"取消");
    } withDoneHandler:^(NSInteger selectedIndex, NSString *selectedValue) {
        [titleBtn setTitle:selectedValue forState:UIControlStateNormal];
    }];
    
    
    
}

#pragma mark -- 添加子试图
-(void)addSubviews {
    // 添加左边日期按钮
    dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dateBtn.frame = CGRectMake(0, 64, kScreenWidth/5, 40);
    monthDate = [NSDate date];
    [dateBtn setTitle:[NSString stringWithFormat:@"%ld-%.2ld",(long)[self year:monthDate],(long)[self month:monthDate]] forState:UIControlStateNormal];
    [dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(showCalenderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dateBtn];
    
    // 今
    UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    todayBtn.frame = CGRectMake((kScreenWidth/8.0-25)/2, 10, 25, 25);
    [todayBtn setTitle:@"今" forState:UIControlStateNormal];
    [todayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    todayBtn.layer.borderWidth = 1;
    todayBtn.layer.cornerRadius = 2;
    todayBtn.layer.masksToBounds = YES;
    [todayBtn addTarget:self action:@selector(backTodayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:todayBtn];
    [self.view addSubview:self.backView2];
    [self.backView2 addSubview:todayBtn];
    
    // 右边日历
    [self.backView2 addSubview:self.weekClaendar];
    
    [self.view addSubview:self.scrollerView];
    
}

#pragma mark -- 回到今天日期 
-(void)backTodayClick {
    [self.weekClaendar setSelectedDate:[NSDate date] animated:YES];
}

#pragma mark -- 弹出日历
-(void)showCalenderView:(UIButton *)sender {
    sender.selected = !sender.selected;
    isShowCalendar = !isShowCalendar;
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    [keyWindow addSubview:self.backView];
    [self.backView addSubview:self.calendarView];
    
    if (isShowCalendar) {
        self.backView.hidden = NO;
        self.calendarView.hidden = NO;
        self.calendarView.frame = calendarRect;
        
        __weak typeof(dateBtn) weakDateBtn = dateBtn;
        self.calendarView.didSelectDayHandler = ^(NSInteger year,NSInteger month,NSInteger day,BOOL isClick) {
            
            [weakDateBtn setTitle:[NSString stringWithFormat:@"%ld-%ld",year,month] forState:UIControlStateNormal];
            
        };
        
    }else {
        [UIView animateWithDuration:0.45 animations:^{
            
//            self.calendarView.frame = CGRectMake(0, -300, kScreenWidth, 200);
            
        } completion:^(BOOL finished) {
            self.calendarView.hidden = YES;
            self.backView.hidden = YES;
        }];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark --ASWeekSelectorViewDelegate




#pragma mark- private
- (NSInteger)month:(NSDate *)date
{
    return [self getDateComponentsFromDate:date].month;
}

- (NSInteger)year:(NSDate *)date
{
    return [self getDateComponentsFromDate:date].year;
}

- (NSDate *)lastMonthDate:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    NSInteger currentMonth = [self month:date];
    if(currentMonth == 1)
    {
        dateComponents.year = -1;
        dateComponents.month = +11;
    }
    else
        dateComponents.month = -1;
    
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:NSCalendarWrapComponents];
    return newDate;
}
- (NSDate*)nextMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    NSInteger currentMonth = [self month:date];
    if(currentMonth == 12)
    {
        dateComponents.year = +1;
        dateComponents.month = -11;
    }
    else
        dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:NSCalendarWrapComponents];
    return newDate;
}

- (NSDateComponents *)getDateComponentsFromDate:(NSDate *)date
{
    NSDateComponents *component = [[NSCalendar currentCalendar] components:
                                   (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return component;
}



@end
