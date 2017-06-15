//
//  GFCalendarScrollView.m
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import "GFCalendarScrollView.h"
#import "GFCalendarCell.h"
#import "GFCalendarMonth.h"
#import "NSDate+GFCalendar.h"

#import "DAYUtils.h"

@interface GFCalendarScrollView() <UICollectionViewDataSource, UICollectionViewDelegate> {
    NSInteger firstWeekDayTag;
}

@property (nonatomic, strong) UICollectionView *collectionViewL;
@property (nonatomic, strong) UICollectionView *collectionViewM;
@property (nonatomic, strong) UICollectionView *collectionViewR;

@property (nonatomic, strong) NSDate *currentMonthDate;

@property (nonatomic, strong) NSMutableArray *monthArray;

@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) NSString *todayStr;

@end

@implementation GFCalendarScrollView

#define kCalendarBasicColor [UIColor colorWithRed:231.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1.0]
//#define kCalendarBasicColor [UIColor colorWithRed:252.0 / 255.0 green:60.0 / 255.0 blue:60.0 / 255.0 alpha:1.0]

static NSString *const kCellIdentifier = @"cell";


#pragma mark - Initialiaztion

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        
        self.contentSize = CGSizeMake(3 * self.bounds.size.width, self.bounds.size.height);
        [self setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO];
        
        _currentMonthDate = [NSDate date];
        [self setupCollectionViews];
        
        _cellArray = [NSMutableArray array];
    }
    
    return self;
    
}

- (NSMutableArray *)monthArray {
    
    if (_monthArray == nil) {
        
        _monthArray = [NSMutableArray arrayWithCapacity:4];
        
        NSDate *previousMonthDate = [_currentMonthDate previousMonthDate];
        NSDate *nextMonthDate = [_currentMonthDate nextMonthDate];
        
        [_monthArray addObject:[[GFCalendarMonth alloc] initWithDate:previousMonthDate]];
        [_monthArray addObject:[[GFCalendarMonth alloc] initWithDate:_currentMonthDate]];
        [_monthArray addObject:[[GFCalendarMonth alloc] initWithDate:nextMonthDate]];
        [_monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]]; // 存储左边的月份的前一个月份的天数，用来填充左边月份的首部
        
        // 发通知，更改当前月份标题
        [self notifyToChangeCalendarHeader];
    }
    
    return _monthArray;
}

- (NSNumber *)previousMonthDaysForPreviousDate:(NSDate *)date {
    return [[NSNumber alloc] initWithInteger:[[date previousMonthDate] totalDaysInMonth]];
}


- (void)setupCollectionViews {
        
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width / 7.0, self.bounds.size.width / 7.0 * 1.2);
    flowLayout.minimumLineSpacing = 1;    //  行间距
    flowLayout.minimumInteritemSpacing = 0.0;   //  cell 之间的间距
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat selfHeight = self.bounds.size.height;
    
    _collectionViewL = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    _collectionViewL.dataSource = self;
    _collectionViewL.delegate = self;
    _collectionViewL.backgroundColor = Back_Color;
    [_collectionViewL registerClass:[GFCalendarCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:_collectionViewL];
    
    _collectionViewM = [[UICollectionView alloc] initWithFrame:CGRectMake(selfWidth, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    _collectionViewM.dataSource = self;
    _collectionViewM.delegate = self;
    _collectionViewM.backgroundColor = Back_Color;
    [_collectionViewM registerClass:[GFCalendarCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:_collectionViewM];
    
    _collectionViewR = [[UICollectionView alloc] initWithFrame:CGRectMake(2 * selfWidth, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    _collectionViewR.dataSource = self;
    _collectionViewR.delegate = self;
    _collectionViewR.backgroundColor = Back_Color;
    [_collectionViewR registerClass:[GFCalendarCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:_collectionViewR];

}


#pragma mark -

- (void)notifyToChangeCalendarHeader {
    
    GFCalendarMonth *currentMonthInfo = self.monthArray[1];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [userInfo setObject:[[NSNumber alloc] initWithInteger:currentMonthInfo.year] forKey:@"year"];
    [userInfo setObject:[[NSNumber alloc] initWithInteger:currentMonthInfo.month] forKey:@"month"];
    [userInfo setObject:[[NSNumber alloc] initWithInteger:currentMonthInfo.day] forKey:@"day"];
    
    NSNotification *notify = [[NSNotification alloc] initWithName:@"ChangeCalendarHeaderNotification" object:nil userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notify];
}

- (void)refreshToCurrentMonth {
    
    // 如果现在就在当前月份，则不执行操作
    GFCalendarMonth *currentMonthInfo = self.monthArray[1];
    if ((currentMonthInfo.month == [[NSDate date] dateMonth]) && (currentMonthInfo.year == [[NSDate date] dateYear])) {
        return;
    }
    
    _currentMonthDate = [NSDate date];
    
    NSDate *previousMonthDate = [_currentMonthDate previousMonthDate];
    NSDate *nextMonthDate = [_currentMonthDate nextMonthDate];
    
    [self.monthArray removeAllObjects];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:previousMonthDate]];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:_currentMonthDate]];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:nextMonthDate]];
    [self.monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]];
    
    // 刷新数据
    [_collectionViewM reloadData];
    [_collectionViewL reloadData];
    [_collectionViewR reloadData];
    
}


#pragma mark - UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 35; // 7 * 6
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GFCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if (collectionView == _collectionViewL) {
        
        GFCalendarMonth *monthInfo = self.monthArray[0];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        firstWeekDayTag = firstWeekday;
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.todayLabel.textColor = Font_Color;
            
            /*
             *农历
             */
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            comps.day = indexPath.row-firstWeekday+1;
            comps.month = monthInfo.month;
            comps.year = monthInfo.year;
            
            NSDate *dateFromDateComponentsForDate = [[DAYUtils localCalendar] dateFromComponents:comps];
            cell.subTitle.text = [DAYUtils LunarForSolarYear:dateFromDateComponentsForDate];
            cell.subTitle.textColor = Font_Color;
            
            if (indexPath.row == 7 || indexPath.row == 14 || indexPath.row == 21 || indexPath.row == 28 || indexPath.row == 6 || indexPath.row == 13 || indexPath.row == 20 || indexPath.row == 27) {
                cell.todayLabel.textColor = Font_Week_Color;
                cell.subTitle.textColor = Font_Week_Color;
            }
            
            // 标识今天
            if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                    cell.todayCircle.backgroundColor = kCalendarBasicColor;
                    cell.todayLabel.textColor = [UIColor whiteColor];
//                    [_cellArray addObject:cell];
                } else {
                    cell.todayCircle.backgroundColor = [UIColor clearColor];
                }
            } else {
                cell.todayCircle.backgroundColor = [UIColor clearColor];
            }
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            int totalDaysOflastMonth = [self.monthArray[3] intValue];
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", totalDaysOflastMonth - (firstWeekday - indexPath.row) + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
            
            
            cell.subTitle.textColor = [UIColor clearColor];  // 2017/06/02
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday - totalDays + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
            
            cell.subTitle.textColor = [UIColor clearColor];  // 2017/06/02
        }
        
        cell.userInteractionEnabled = NO;
        
    }
    else if (collectionView == _collectionViewM) {
        
        GFCalendarMonth *monthInfo = self.monthArray[1];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        firstWeekDayTag = firstWeekday;
        
        
       _todayStr = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.userInteractionEnabled = YES;
            cell.todayLabel.textColor = Font_Color;
            
            /*
             *农历
             */
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            comps.day = indexPath.row-firstWeekday+1;
            comps.month = monthInfo.month;
            comps.year = monthInfo.year;
            
            NSDate *dateFromDateComponentsForDate = [[DAYUtils localCalendar] dateFromComponents:comps];
            cell.subTitle.text = [DAYUtils LunarForSolarYear:dateFromDateComponentsForDate];
            cell.subTitle.textColor = Font_Color;
            
            if (indexPath.row == 7 || indexPath.row == 14 || indexPath.row == 21 || indexPath.row == 28 || indexPath.row == 6 || indexPath.row == 13 || indexPath.row == 20 || indexPath.row == 27) {
                cell.todayLabel.textColor = Font_Week_Color;
                cell.subTitle.textColor = Font_Week_Color;
            }
           
            // 标识今天
            if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                    cell.todayCircle.backgroundColor = kCalendarBasicColor;
                    cell.todayLabel.textColor = [UIColor blackColor];
                    if (_isShowTodayStr) {
                        cell.todayName = @"今天"; // 作为属性拿出来
                        _isShowTodayStr = NO;
                    }
                    [_cellArray addObject:cell];
                } else {
                    cell.todayCircle.backgroundColor = [UIColor clearColor];
                }
            } else {
                cell.todayCircle.backgroundColor = [UIColor clearColor];
            }
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            GFCalendarMonth *lastMonthInfo = self.monthArray[0];
            NSInteger totalDaysOflastMonth = lastMonthInfo.totalDays;
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", totalDaysOflastMonth - (firstWeekday - indexPath.row) + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
            cell.userInteractionEnabled = NO;
            
            cell.subTitle.textColor = [UIColor clearColor];  // 2017/06/02
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday - totalDays + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
            cell.userInteractionEnabled = NO;
            
            cell.subTitle.textColor = [UIColor clearColor];  // 2017/06/02
        }
        
    }
    else if (collectionView == _collectionViewR) {
        
        GFCalendarMonth *monthInfo = self.monthArray[2];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        firstWeekDayTag = firstWeekday;
        
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.todayLabel.textColor = Font_Color;
            
            /*
             *农历
             */
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            comps.day = indexPath.row-firstWeekday+1;
            comps.month = monthInfo.month;
            comps.year = monthInfo.year;
            
            NSDate *dateFromDateComponentsForDate = [[DAYUtils localCalendar] dateFromComponents:comps];
            cell.subTitle.text = [DAYUtils LunarForSolarYear:dateFromDateComponentsForDate];
            cell.subTitle.textColor = Font_Color;
            
            if (indexPath.row == 7 || indexPath.row == 14 || indexPath.row == 21 || indexPath.row == 28 || indexPath.row == 6 || indexPath.row == 13 || indexPath.row == 20 || indexPath.row == 27) {
                cell.todayLabel.textColor = Font_Week_Color;
                cell.subTitle.textColor = Font_Week_Color;
            }
            
            // 标识今天
            if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                    cell.todayCircle.backgroundColor = kCalendarBasicColor;
                    cell.todayLabel.textColor = [UIColor whiteColor];
//                    [_cellArray addObject:cell];
                } else {
                    cell.todayCircle.backgroundColor = [UIColor clearColor];
                }
            } else {
                cell.todayCircle.backgroundColor = [UIColor clearColor];
            }
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            GFCalendarMonth *lastMonthInfo = self.monthArray[1];
            NSInteger totalDaysOflastMonth = lastMonthInfo.totalDays;
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", totalDaysOflastMonth - (firstWeekday - indexPath.row) + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
            
            
            cell.subTitle.textColor = [UIColor clearColor];  // 2017/06/02
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday - totalDays + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
            
            cell.subTitle.textColor = [UIColor clearColor];  // 2017/06/02
        }
        
        cell.userInteractionEnabled = NO;
        
    }
    
    return cell;
    
}


#pragma mark - UICollectionViewDeleagate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.didSelectDayHandler != nil) {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:_currentMonthDate];
        NSDate *currentDate = [calendar dateFromComponents:components];
        
        GFCalendarCell *cell = (GFCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        for (GFCalendarCell *cellOne in _cellArray) {
            cellOne.todayCircle.backgroundColor = [UIColor clearColor];
//            cellOne.todayName = _todayStr;
        }
        [_cellArray removeAllObjects];
        
        cell.todayCircle.backgroundColor = kCalendarBasicColor;
//        _todayStr = cell.todayLabel.text;
        [_cellArray addObject:cell];
        
        NSInteger year = [currentDate dateYear];
        NSInteger month = [currentDate dateMonth];
        NSInteger day;
        if ([cell.todayLabel.text integerValue] > 0) {
            day = [cell.todayLabel.text integerValue];
        }else {
            day = [[NSDate date] dateDay];
        }
        
        
        self.didSelectDayHandler(year, month, day,YES); // 执行回调
    }
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView != self) {
        return;
    }
    
    // 向右滑动
    if (scrollView.contentOffset.x < self.bounds.size.width) {
        
        _currentMonthDate = [_currentMonthDate previousMonthDate];
        NSDate *previousDate = [_currentMonthDate previousMonthDate];
        
        // 数组中最左边的月份现在作为中间的月份，中间的作为右边的月份，新的左边的需要重新获取
        GFCalendarMonth *currentMothInfo = self.monthArray[0];
        GFCalendarMonth *nextMonthInfo = self.monthArray[1];
        
        
        GFCalendarMonth *olderNextMonthInfo = self.monthArray[2];
        
        // 复用 GFCalendarMonth 对象
        olderNextMonthInfo.totalDays = [previousDate totalDaysInMonth];
        olderNextMonthInfo.firstWeekday = [previousDate firstWeekDayInMonth];
        olderNextMonthInfo.year = [previousDate dateYear];
        olderNextMonthInfo.month = [previousDate dateMonth];
        GFCalendarMonth *previousMonthInfo = olderNextMonthInfo;
        
        NSNumber *prePreviousMonthDays = [self previousMonthDaysForPreviousDate:[_currentMonthDate previousMonthDate]];
        
        [self.monthArray removeAllObjects];
        [self.monthArray addObject:previousMonthInfo];
        [self.monthArray addObject:currentMothInfo];
        [self.monthArray addObject:nextMonthInfo];
        [self.monthArray addObject:prePreviousMonthDays];
        
    }
    // 向左滑动
    else if (scrollView.contentOffset.x > self.bounds.size.width) {
        
        _currentMonthDate = [_currentMonthDate nextMonthDate];
        NSDate *nextDate = [_currentMonthDate nextMonthDate];
        
        // 数组中最右边的月份现在作为中间的月份，中间的作为左边的月份，新的右边的需要重新获取
        GFCalendarMonth *previousMonthInfo = self.monthArray[1];
        GFCalendarMonth *currentMothInfo = self.monthArray[2];
        
        
        GFCalendarMonth *olderPreviousMonthInfo = self.monthArray[0];
        
        NSNumber *prePreviousMonthDays = [[NSNumber alloc] initWithInteger:olderPreviousMonthInfo.totalDays]; // 先保存 olderPreviousMonthInfo 的月天数
        
        // 复用 GFCalendarMonth 对象
        olderPreviousMonthInfo.totalDays = [nextDate totalDaysInMonth];
        olderPreviousMonthInfo.firstWeekday = [nextDate firstWeekDayInMonth];
        olderPreviousMonthInfo.year = [nextDate dateYear];
        olderPreviousMonthInfo.month = [nextDate dateMonth];
        GFCalendarMonth *nextMonthInfo = olderPreviousMonthInfo;

        
        [self.monthArray removeAllObjects];
        [self.monthArray addObject:previousMonthInfo];
        [self.monthArray addObject:currentMothInfo];
        [self.monthArray addObject:nextMonthInfo];
        [self.monthArray addObject:prePreviousMonthDays];
        
    }
    
    [_collectionViewM reloadData]; // 中间的 collectionView 先刷新数据
    [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO]; // 然后变换位置
    [_collectionViewL reloadData]; // 最后两边的 collectionView 也刷新数据
    [_collectionViewR reloadData];
    
    // 发通知，更改当前月份标题
    [self notifyToChangeCalendarHeader];
    
}

-(void)previousMonth {
    _currentMonthDate = [_currentMonthDate previousMonthDate];
    NSDate *previousDate = [_currentMonthDate previousMonthDate];
    
    // 数组中最左边的月份现在作为中间的月份，中间的作为右边的月份，新的左边的需要重新获取
    GFCalendarMonth *currentMothInfo = self.monthArray[0];
    GFCalendarMonth *nextMonthInfo = self.monthArray[1];
    
    
    GFCalendarMonth *olderNextMonthInfo = self.monthArray[2];
    
    // 复用 GFCalendarMonth 对象
    olderNextMonthInfo.totalDays = [previousDate totalDaysInMonth];
    olderNextMonthInfo.firstWeekday = [previousDate firstWeekDayInMonth];
    olderNextMonthInfo.year = [previousDate dateYear];
    olderNextMonthInfo.month = [previousDate dateMonth];
    GFCalendarMonth *previousMonthInfo = olderNextMonthInfo;
    
    NSNumber *prePreviousMonthDays = [self previousMonthDaysForPreviousDate:[_currentMonthDate previousMonthDate]];
    
    [self.monthArray removeAllObjects];
    [self.monthArray addObject:previousMonthInfo];
    [self.monthArray addObject:currentMothInfo];
    [self.monthArray addObject:nextMonthInfo];
    [self.monthArray addObject:prePreviousMonthDays];
    
    [_collectionViewM reloadData]; // 中间的 collectionView 先刷新数据
    
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO]; // 然后变换位置
    
    [_collectionViewL reloadData]; // 最后两边的 collectionView 也刷新数据
    [_collectionViewR reloadData];
    
    // 发通知，更改当前月份标题
    [self notifyToChangeCalendarHeader];


}

-(void)nextModth {
    _currentMonthDate = [_currentMonthDate nextMonthDate];
    NSDate *nextDate = [_currentMonthDate nextMonthDate];
    
    // 数组中最右边的月份现在作为中间的月份，中间的作为左边的月份，新的右边的需要重新获取
    GFCalendarMonth *previousMonthInfo = self.monthArray[1];
    GFCalendarMonth *currentMothInfo = self.monthArray[2];
    
    
    GFCalendarMonth *olderPreviousMonthInfo = self.monthArray[0];
    
    NSNumber *prePreviousMonthDays = [[NSNumber alloc] initWithInteger:olderPreviousMonthInfo.totalDays]; // 先保存 olderPreviousMonthInfo 的月天数
    
    // 复用 GFCalendarMonth 对象
    olderPreviousMonthInfo.totalDays = [nextDate totalDaysInMonth];
    olderPreviousMonthInfo.firstWeekday = [nextDate firstWeekDayInMonth];
    olderPreviousMonthInfo.year = [nextDate dateYear];
    olderPreviousMonthInfo.month = [nextDate dateMonth];
    GFCalendarMonth *nextMonthInfo = olderPreviousMonthInfo;
    
    
    [self.monthArray removeAllObjects];
    [self.monthArray addObject:previousMonthInfo];
    [self.monthArray addObject:currentMothInfo];
    [self.monthArray addObject:nextMonthInfo];
    [self.monthArray addObject:prePreviousMonthDays];
    
    [_collectionViewM reloadData]; // 中间的 collectionView 先刷新数据
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO]; // 然后变换位置
    [_collectionViewL reloadData]; // 最后两边的 collectionView 也刷新数据
    [_collectionViewR reloadData];
    
    // 发通知，更改当前月份标题
    [self notifyToChangeCalendarHeader];
}


@end
