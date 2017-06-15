//
//  HomePagesController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/8.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "HomePagesController.h"
#import "NSDate+GFCalendar.h"
#import "GFCalendarView.h"
#import "DrawLabel.h"

#import "CoursePlanCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface HomePagesController () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *contentView;


@property (nonatomic,strong) UILabel *venuesName;  // 场馆名字
@property (nonatomic,strong) UIButton *changeBtn;  // 切换场馆

@property (nonatomic,strong) UILabel *todayLabel;
@property (nonatomic,strong) UILabel *tomorrowLabel;
@property (nonatomic,strong) UILabel *nextDayLabel;
@property (nonatomic,strong) UIView  *moveView;

@property (nonatomic,strong) UIView  *showCalendarBack;
@property (nonatomic,strong) GFCalendarView *calendarView;

@property (nonatomic,strong) DrawLabel *labelOne;
@property (nonatomic,strong) DrawLabel *labelTwo;
@property (nonatomic,strong) DrawLabel *labelThree;

@property (nonatomic,strong) UIRefreshControl *refresh;

@property (nonatomic,strong) UITableView *coursePlanTableView;

#define dateFormatDefine @"yyyy-MM-dd"

@end

static NSString *PlanCell = @"planCell";

@implementation HomePagesController


#pragma mark -- 懒加载
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.delegate = self;
//        scrollView.contentSize = CGSizeMake(0, kScreenHeight*2);
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 352)];
        _contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentView;
}
-(UILabel *)venuesName {
    if (!_venuesName) {
        _venuesName = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth/2.0-10, 40)];
        _venuesName.textAlignment = NSTextAlignmentLeft;
        _venuesName.text = @"全部场馆";
    }
    return _venuesName;
}
-(UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeBtn.frame = CGRectMake(kScreenWidth/4.0*3-10, 10, kScreenWidth/4.0-10, 30);
        [_changeBtn setTitle:@"切换场馆" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _changeBtn.layer.borderWidth = 1;
        _changeBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _changeBtn.layer.cornerRadius = 5;
        _changeBtn.layer.masksToBounds = YES;
        [_changeBtn addTarget:self action:@selector(changeNameClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _changeBtn;
}
-(UIView *)showCalendarBack {
    if (!_showCalendarBack) {
        _showCalendarBack = [[UIView alloc]initWithFrame:self.view.bounds];
        _showCalendarBack.backgroundColor = [UIColor lightGrayColor];
        _showCalendarBack.alpha = 0.5;
        
    }
    return _showCalendarBack;
}

-(GFCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[GFCalendarView alloc]initWithFrameOrigin:CGPointMake(0, (kScreenHeight-kScreenWidth)/2.0) width:kScreenWidth];
        _calendarView.isShowTopView = YES;
    }
    return _calendarView;
}

-(UIView *)moveView {
    if (!_moveView) {
        _moveView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth/4.0, 5)];
        _moveView.backgroundColor = [UIColor blueColor];
    }
    return _moveView;
}

-(UIRefreshControl *)refresh {
    if (!_refresh) {
        UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
        refresh.tintColor = [UIColor blueColor];//控制菊花的颜色
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"刷刷刷"];
        refresh.attributedTitle = string;//菊花下面的文字，可利用NSAttributedString设置各种文字属性
        [refresh addTarget:self action:@selector(startRefresh) forControlEvents:(UIControlEventValueChanged)];//刷新方法
        _refresh = refresh;
    }
    return _refresh;
}

-(UITableView *)coursePlanTableView {
    if (!_coursePlanTableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        _coursePlanTableView = tableView;
    }
    return _coursePlanTableView;
}

#pragma mark -- 刷新
-(void)startRefresh {
    NSLog(@"ww");
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, -20);
    } completion:^(BOOL finished) {
//        self.scrollView.contentOffset = CGPointMake(0, 20);
        self.refresh = nil;
        
    }];
    
}

#pragma mark -- scrollView 代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.y < -20) {
//        scrollView.refreshControl = self.refresh;
//        
//    }
}

//视图减速结束时触发的方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    scrollView.contentOffset = CGPointMake(0, 0);
}

#pragma mark -- tableView 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 注册模型cell
//    [self.coursePlanTableView startAutoCellHeightWithCellClass:[CoursePlanCell class] contentViewWidth:kScreenWidth];
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoursePlanCell *cell = [tableView dequeueReusableCellWithIdentifier:PlanCell];
    if (!cell) {
        cell = [[CoursePlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlanCell];
    }
    
    cell.textLabel.text = @"q";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 根据模型取得cell高度
//    return [self.coursePlanTableView cellHeightForIndexPath:indexPath model:nil keyPath:@"Model"];
    
    return 60;
}


#pragma mark -- 切换场馆
-(void)changeNameClick {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self commonInit];
    
    
    // Do any additional setup after loading the view.
}

-(void)commonInit {
    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:self.contentView];
    
    [self.scrollView addSubview:self.coursePlanTableView];
    self.coursePlanTableView.tableHeaderView = self.contentView;
    self.coursePlanTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新了");
        [self.coursePlanTableView.mj_header endRefreshing];
    }];
    [self.coursePlanTableView.mj_header beginRefreshing];
    
    
//    NSDictionary *tmpViewsDictionary = @{@"scrollView":self.scrollView,
//                                         @"contentView":self.contentView};
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[scrollView]-(0)-|" options:0 metrics:nil views:tmpViewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[scrollView]-(0)-|" options:0 metrics:nil views:tmpViewsDictionary]];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[contentView]-(0)-|" options:0 metrics:nil views:tmpViewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[contentView]-(0)-|" options:0 metrics:nil views:tmpViewsDictionary]];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    [self addContentSubViews];
}

-(void)addContentSubViews {
    UIView *myPageBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    myPageBackView.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:myPageBackView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 150)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.userInteractionEnabled = YES;
     [self.contentView addSubview:backView];
    
    [backView addSubview:self.venuesName];
    [backView addSubview:self.changeBtn];
    
    self.todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth/4.0, 60)];
    self.todayLabel.numberOfLines = 2;
    self.todayLabel.textAlignment = NSTextAlignmentCenter;
    NSDate *today = [NSDate date];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM.dd"];
    self.todayLabel.text = [NSString stringWithFormat:@"%@\n今天",[dateday stringFromDate:today]];
    [backView addSubview:self.todayLabel];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 50, kScreenWidth/4.0, 60);
    button1.backgroundColor = [UIColor clearColor];
    button1.tag = 1;
    [button1 addTarget:self action:@selector(choseDtaeClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4.0, 55, 1, 50)];
    label.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:label];
    
    self.tomorrowLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4.0, 50, kScreenWidth/4.0, 60)];
    self.tomorrowLabel.numberOfLines = 2;
    self.tomorrowLabel.textAlignment = NSTextAlignmentCenter;
    self.tomorrowLabel.text = [NSString stringWithFormat:@"%@\n明天",[self getTomorrowDay:today]];
    [backView addSubview:self.tomorrowLabel];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth/4.0, 50, kScreenWidth/4.0, 60);
    button2.backgroundColor = [UIColor clearColor];
    button2.tag = 2;
    [button2 addTarget:self action:@selector(choseDtaeClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4.0*2, 55, 1, 50)];
    label2.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:label2];
    
    self.nextDayLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4.0*2, 50, kScreenWidth/4.0, 60)];
    self.nextDayLabel.numberOfLines = 2;
    self.nextDayLabel.textAlignment = NSTextAlignmentCenter;
    self.nextDayLabel.text = [NSString stringWithFormat:@"%@\n后天",[self getNextDay:today]];
    [backView addSubview:self.nextDayLabel];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(kScreenWidth/4.0*2, 50, kScreenWidth/4.0, 60);
    button3.backgroundColor = [UIColor clearColor];
    button3.tag = 3;
    [button3 addTarget:self action:@selector(choseDtaeClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button3];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4.0*3, 55, 1, 50)];
    label3.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:label3];
    
    UIButton *calendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calendarBtn.frame = CGRectMake(kScreenWidth/4.0*3, 50, kScreenWidth/4.0, 60);
    [calendarBtn setTitle:@"日历" forState:UIControlStateNormal];
    [calendarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [calendarBtn addTarget:self action:@selector(shouCalendarClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:calendarBtn];
    
    [backView addSubview:self.moveView];
    
    self.labelOne = [[DrawLabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/5.0*3-40)/2.0, 110, kScreenWidth/5.0, 30) fillColor:[UIColor blueColor] titleLable:@"全部"];
    [backView addSubview:self.labelOne];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.labelOne.frame.size.width, self.labelOne.frame.size.height);
    button.tag = 10;
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.labelOne addSubview:button];
    
    self.labelTwo = [[DrawLabel alloc]initWithFrame:self.labelOne.frame fillColor:[UIColor lightGrayColor] titleLable:@"私教"];
    self.labelTwo.labelColor = [UIColor grayColor];
    [backView addSubview:self.labelTwo];
    [self.labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelOne);
        make.left.equalTo(self.labelOne.mas_right).with.offset(20);
        make.width.equalTo(self.labelOne);
        make.height.equalTo(self.labelOne);
        
    }];
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTwo.frame = CGRectMake(0, 0, self.labelTwo.frame.size.width, self.labelTwo.frame.size.height);
    buttonTwo.tag = 11;
    [buttonTwo setBackgroundColor:[UIColor clearColor]];
    [buttonTwo addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.labelTwo addSubview:buttonTwo];
    
    self.labelThree = [[DrawLabel alloc]initWithFrame:self.labelOne.frame fillColor:[UIColor lightGrayColor] titleLable:@"团课"];
    self.labelThree.labelColor = [UIColor grayColor];
    [backView addSubview:self.labelThree];
    [self.labelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelTwo);
        make.left.equalTo(self.labelTwo.mas_right).with.offset(20);
        make.width.equalTo(self.labelOne);
        make.height.equalTo(self.labelOne);
    }];
    UIButton *buttonThree = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonThree.frame = CGRectMake(0, 0, self.labelThree.frame.size.width, self.labelThree.frame.size.height);
    buttonThree.tag = 12;
    [buttonThree setBackgroundColor:[UIColor clearColor]];
    [buttonThree addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.labelThree addSubview:buttonThree];
    
    // 添加tableview
//    [self.contentView addSubview:self.coursePlanTableView];
    
}

#pragma mark -- 改变三个按钮选择
-(void)changeBtnClick:(UIButton *)sender {
    if (sender.tag == 10) {
        self.labelOne.labelColor = [UIColor whiteColor];
        self.labelOne.fillColor = [UIColor blueColor];
        
        self.labelTwo.labelColor = [UIColor grayColor];
        self.labelTwo.fillColor = [UIColor lightGrayColor];
        self.labelThree.labelColor = [UIColor grayColor];
        self.labelThree.fillColor = [UIColor lightGrayColor];
    }else if (sender.tag == 11) {
        self.labelTwo.labelColor = [UIColor whiteColor];
        self.labelTwo.fillColor = [UIColor blueColor];
        
        self.labelOne.labelColor = [UIColor grayColor];
        self.labelOne.fillColor = [UIColor lightGrayColor];
        self.labelThree.labelColor = [UIColor grayColor];
        self.labelThree.fillColor = [UIColor lightGrayColor];
    }else {
        self.labelThree.labelColor = [UIColor whiteColor];
        self.labelThree.fillColor = [UIColor blueColor];
        
        self.labelOne.labelColor = [UIColor grayColor];
        self.labelOne.fillColor = [UIColor lightGrayColor];
        self.labelTwo.labelColor = [UIColor grayColor];
        self.labelTwo.fillColor = [UIColor lightGrayColor];
    }
}

#pragma mark -- 选择日期按钮
-(void)choseDtaeClick:(UIButton *)sender {
    self.moveView.frame = CGRectMake((sender.tag-1)*kScreenWidth/4.0, 100, kScreenWidth/4.0, 5);
}

#pragma mark -- 弹出日历
-(void)shouCalendarClick {
    [self.view addSubview:self.showCalendarBack];
    [self createOneGRWithType:Tap andAddView:_showCalendarBack];
    [self.view addSubview:self.calendarView];
    __weak typeof(self) weakSelf = self;
    self.calendarView.didSelectDayHandler = ^(NSInteger year,NSInteger month,NSInteger day,BOOL isClick) {
        NSLog(@"%ld",day);
        
        if (isClick) {
            NSDate *date = [weakSelf dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day]];
            weakSelf.todayLabel.text = [NSString stringWithFormat:@"%@\n%@",[weakSelf stringFromDate:date],[weakSelf weekdayStringFromDate:date]];
            
            [weakSelf.showCalendarBack removeFromSuperview];
            [weakSelf.calendarView removeFromSuperview];
        }
        
    };
}

//时间字符串转换为日期格式
- (NSDate *)dateFromString:(NSString *)str{
    //实例化一个NSDateFormatter对象
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    // 设置时间格式的时区 东八区 北京时间
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [dateFormat dateFromString:str];
}
//日期转换为时间字符串
- (NSString *)stringFromDate:(NSDate *)date {
    //实例化一个NSDateFormatter对象
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormat setDateFormat:@"MM.dd"];
    // 设置时间格式的时区 东八区 北京时间
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [dateFormat stringFromDate:date];
}

#pragma mark -- 根据日期计算星期几
-(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}



#pragma mark -- 重写父类手势tap方法
-(void)TapGRClick:(UITapGestureRecognizer *)sender {
    if (sender.view == self.showCalendarBack) {
        [self.showCalendarBack removeFromSuperview];
        [self.calendarView removeFromSuperview];
    }
}

#pragma mark -- 获取明天时间
-(NSString *)getTomorrowDay:(NSDate *)aDate{
    NSDate *tomorrow = [NSDate dateWithTimeInterval:24*60*60 sinceDate:aDate];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM.dd"];
    return [dateday stringFromDate:tomorrow];
}
-(NSString *)getNextDay:(NSDate *)aDate {
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60*2 sinceDate:aDate];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM.dd"];
    return [dateday stringFromDate:nextDay];
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
