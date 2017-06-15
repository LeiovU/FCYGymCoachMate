//
//  PlanModel.h
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/17.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanModel : NSObject


@property (nonatomic,strong) NSString *category;   // 类别
@property (nonatomic,strong) NSString *dateStr;   // 日期
@property (nonatomic,strong) NSString *time;     // 时间
@property (nonatomic,strong) NSString *imgStr;    // 图片

@end
