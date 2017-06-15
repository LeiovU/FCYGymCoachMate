//
//  CYButton.h
//  蚁巢
//
//  Created by 张春雨 on 2016/11/17.
//  Copyright © 2016年 张春雨. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SetBtnContent) {
    SetBtnContentLeftAndRight,
    SetBtnContentUpAndDown
};

@interface CYButton : UIButton
/** item */
@property (weak , nonatomic) UITabBarItem *item;

@property (nonatomic,assign) SetBtnContent design;
@end
