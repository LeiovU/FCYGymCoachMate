//
//  ChoseGymController.h
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/3.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "FCYRootViewController.h"

typedef void(^TitleChoseBlock)(NSString *title);

@interface ChoseGymController : FCYRootViewController

@property (nonatomic,copy)TitleChoseBlock block;

-(void)returnTitle:(TitleChoseBlock)block;

@end
