//
//  DrawLabel.h
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/8.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLabel : UIView

@property (nonatomic, copy)NSString  *title;
@property (nonatomic, strong)UIColor *fillColor;
@property (nonatomic, strong)UILabel *titleLable;
@property (nonatomic, strong)UIColor *labelColor;

-(instancetype)initWithFrame:(CGRect)frame fillColor:(UIColor *)fillClor titleLable:(NSString *)title;

@end
