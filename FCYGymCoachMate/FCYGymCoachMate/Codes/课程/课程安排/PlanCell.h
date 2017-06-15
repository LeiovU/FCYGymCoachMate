//
//  PlanCell.h
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/6/13.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol moveDelegate <NSObject>

-(void)cellWith:(NSIndexPath * )index;//将点击的那个textField所在的cell，在tableView中的位置传到控制器界面

@end

@interface PlanCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic, assign)id<moveDelegate> delegate;

@end
