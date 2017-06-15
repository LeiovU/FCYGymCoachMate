//
//  GFCalendarScrollView.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger,BOOL);

@interface GFCalendarScrollView : UIScrollView


@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler; // 日期点击回调

@property (nonatomic, assign) BOOL isShowTodayStr;


- (void)refreshToCurrentMonth; // 刷新 calendar 回到当前日期月份

-(void)previousMonth;  // 上个月
-(void)nextModth;     // 下个月

@end
