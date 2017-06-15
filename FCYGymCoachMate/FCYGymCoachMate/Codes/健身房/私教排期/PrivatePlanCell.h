//
//  PrivatePlanCell.h
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/17.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlanModel;


@interface PrivatePlanCell : UITableViewCell

@property (nonatomic,strong) PlanModel *model;

//  临时的 设置图片
@property (nonatomic,strong) NSIndexPath *indexPath;


@end
