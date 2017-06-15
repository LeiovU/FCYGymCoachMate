//
//  UIButton+SetImgAndTitle.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/15.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "UIButton+SetImgAndTitle.h"

@implementation UIButton (SetImgAndTitle)


// 上面图片，下面文字的button
-(void)setImageWith:(UIImage *)image andTitle:(NSString *)title {
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat imageH = image.size.height;
    CGFloat imageW = image.size.width;
    
    self.titleLabel.frame = CGRectMake(0, height-imageH, width, 20);
    self.imageView.frame = CGRectMake(0 , 0, imageW, imageH);
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageH, 0, 0, 0)];
//    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, height-imageH, 0)];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
}

@end
