//
//  GFCalendarView.m
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import "GFCalendarView.h"
#import "GFCalendarScrollView.h"
#import "NSDate+GFCalendar.h"

#import "DAYUtils.h"

@interface GFCalendarView()

@property (nonatomic, strong) UIButton *calendarHeaderButton;
@property (nonatomic, strong) UIView *weekHeaderView;
@property (nonatomic, strong) GFCalendarScrollView *calendarScrollView;
@property (nonatomic, strong) UIView *topView;

//topView控件
@property (nonatomic, strong)  UIButton *previousButton;
@property (nonatomic, strong)  UIButton *nextButton;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) NSDate *monthDate;


@end

#define kCalendarBasicColor [UIColor colorWithRed:231.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1.0]
//#define kCalendarBasicColor [UIColor colorWithRed:252.0 / 255.0 green:60.0 / 255.0 blue:60.0 / 255.0 alpha:1.0]

@implementation GFCalendarView


#pragma mark - Initialization

- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width {
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 根据宽度计算 calender 主体部分的高度
    CGFloat weekLineHight = 1.2 * (width / 7.0);
    CGFloat monthHeight = 5 * weekLineHight;
    
    // 星期头部栏高度
    CGFloat weekHeaderHeight = 0.6 * weekLineHight;
    
    // calendar 头部栏高度
    CGFloat calendarHeaderHeight = 0.8 * weekLineHight;
    
    // 最后得到整个 calender 控件的高度
    _calendarHeight = calendarHeaderHeight + weekHeaderHeight + monthHeight;
    
    
    _monthDate = [NSDate date];
//    _isShowTopView = YES;
    
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, width, _calendarHeight)]) {
        
        
        [self addSubview:self.topView];
        [self.topView addSubview:self.previousButton];
        [self.topView addSubview:self.nextButton];
        [self.topView addSubview:self.dateLabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.topView.mas_centerX);
            make.centerY.equalTo(self.topView.mas_centerY);
            
        }];
        
        [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.dateLabel.mas_left).offset(-30);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.centerY.equalTo(self.topView.mas_centerY);
        }];
        
        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel.mas_right).offset(30);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.centerY.equalTo(self.topView.mas_centerY);
        }];

        //  周几
        _weekHeaderView = [self setupWeekHeadViewWithFrame:CGRectMake(0.0, calendarHeaderHeight, width, weekHeaderHeight)];
        _calendarScrollView = [self setupCalendarScrollViewWithFrame:CGRectMake(0.0, calendarHeaderHeight + weekHeaderHeight, width, monthHeight)];
        _calendarScrollView.isShowTodayStr = YES;  // 显示文字 ‘今天’
        
        
        [self addSubview:_calendarHeaderButton];
        [self addSubview:_weekHeaderView];
        [self addSubview:_calendarScrollView];
        
        // 注册 Notification 监听
        [self addNotificationObserver];
        
    }
    
    return self;
    
}

- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- 懒加载
-(UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.frame = CGRectMake(0, 0, self.bounds.size.width, 40);
    }
    return _topView;
}

- (UILabel *)dateLabel
{
    if(_dateLabel == nil)
    {
        _dateLabel = [UILabel new];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [@"#sd72fe" colorValue];
        _dateLabel.font = [UIFont boldSystemFontOfSize:22.0];
        
    }
    return _dateLabel;
}

- (UIButton *)previousButton
{
    if(_previousButton == nil)
    {
        _previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previousButton setBackgroundImage:[UIImage imageNamed:@"sj_07"] forState:UIControlStateNormal];
        [_previousButton addTarget:self action:@selector(previousButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _previousButton.adjustsImageWhenHighlighted = NO; // button 高亮状态消失
        
    }
    return _previousButton;
}



- (UIButton *)nextButton
{
    if(_nextButton == nil)
    {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"sj_08"] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.adjustsImageWhenHighlighted = NO;  // button 高亮状态消失
    }
    return _nextButton;
}


#pragma mark -- 点击方法
- (void)previousButtonClick {
    [self.calendarScrollView previousMonth];
    
    self.monthDate = [self lastMonthDate:self.monthDate];
}

-(void)nextButtonClick{
    [self.calendarScrollView nextModth];
    
    self.monthDate = [self nextMonth:self.monthDate];
}

#pragma mark -- setter 方法
-(void)setMonthDate:(NSDate *)monthDate {
    _monthDate = monthDate;
//    [self.dateLabel setText:[NSString stringWithFormat:@"%ld-%.2ld",(long)[self year:monthDate],(long)[self month:monthDate]]];
    NSString *dateStr = [DAYUtils stringOfMonthInLunarCalendar:(long)[self month:monthDate]];
    [self.dateLabel setText:[NSString stringWithFormat:@"%@月",dateStr]];
}

-(void)setIsShowTopView:(BOOL)isShowTopView {
    _isShowTopView = isShowTopView;
    if (!isShowTopView) {
        [self.topView removeFromSuperview];
    }
}


- (UIButton *)setupCalendarHeaderButtonWithFrame:(CGRect)frame {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = kCalendarBasicColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [button addTarget:self action:@selector(refreshToCurrentMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIView *)setupWeekHeadViewWithFrame:(CGRect)frame {
    
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width / 7.0;
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
//    view.backgroundColor = kCalendarBasicColor;
    view.backgroundColor = [UIColor whiteColor];
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (int i = 0; i < 7; ++i) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0.0, width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = weekArray[i];
        if (i == 0 || i == 6) {
            label.textColor = [UIColor greenColor];
        }else {
            label.textColor = [UIColor blackColor];
        }
        label.font = [UIFont systemFontOfSize:13.5];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
    }
    
    return view;
    
}

- (GFCalendarScrollView *)setupCalendarScrollViewWithFrame:(CGRect)frame {
    GFCalendarScrollView *scrollView = [[GFCalendarScrollView alloc] initWithFrame:frame];
    return scrollView;
}

- (void)setDidSelectDayHandler:(DidSelectDayHandler)didSelectDayHandler {
    _didSelectDayHandler = didSelectDayHandler;
    if (_calendarScrollView != nil) {
        _calendarScrollView.didSelectDayHandler = _didSelectDayHandler; // 传递 block
    }
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCalendarHeaderAction:) name:@"ChangeCalendarHeaderNotification" object:nil];
}


#pragma mark - Actions

- (void)refreshToCurrentMonthAction:(UIButton *)sender {
    
    NSInteger year = [[NSDate date] dateYear];
    NSInteger month = [[NSDate date] dateMonth];
    
    NSString *title = [NSString stringWithFormat:@"%ld年%ld月", year, month];
    
//    [_calendarHeaderButton setTitle:title forState:UIControlStateNormal];
    self.dateLabel.text = title;
    
    [_calendarScrollView refreshToCurrentMonth];
    
}

- (void)changeCalendarHeaderAction:(NSNotification *)sender {
    
    NSDictionary *dic = sender.userInfo;
    
    NSNumber *year = dic[@"year"];
    NSNumber *month = dic[@"month"];
    NSNumber *day = dic[@"day"];
    
//    NSString *title = [NSString stringWithFormat:@"%@年%@月", year, month];
    NSString *dateStr = [DAYUtils stringOfMonthInLunarCalendar:[month integerValue]];
    NSString *title = [NSString stringWithFormat:@"%@月", dateStr];
    self.dateLabel.text = title;
    
    self.didSelectDayHandler([year integerValue],[month integerValue],[day integerValue],NO);
    
//    [_calendarHeaderButton setTitle:title forState:UIControlStateNormal];
}

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
