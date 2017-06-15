//
//  GFCalendarCell.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFCalendarCell : UICollectionViewCell

@property (nonatomic, strong) UIView *todayCircle; //!< 标示'今天'
@property (nonatomic, strong) UILabel *todayLabel; //!< 标示日期（几号）

@property (nonatomic, strong) UILabel *subTitle;  // 农历  2017-06-02

@property (nonatomic,strong) NSString *todayName;

@end
