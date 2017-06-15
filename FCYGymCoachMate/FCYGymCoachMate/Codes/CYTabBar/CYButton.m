//
//  CYButton.m
//  蚁巢
//
//  Created by 张春雨 on 2016/11/17.
//  Copyright © 2016年 张春雨. All rights reserved.
//

#import "CYButton.h"
#import "CYBadgeView.h"

@interface CYButton()
/** remind number */
@property (weak , nonatomic)CYBadgeView * badgeView;
@end

@implementation CYButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[CYTabBarConfig shared].textColor forState:UIControlStateNormal];
        [self setTitleColor:[CYTabBarConfig shared].selectedTextColor forState:UIControlStateSelected];
        
        self.design = SetBtnContentUpAndDown;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.superview.frame.size.height;
    if (width!=0 && height!=0)
    {
        if (self.design == SetBtnContentUpAndDown) {
            self.titleLabel.frame = CGRectMake(0, height-16, width, 16);
            self.imageView.frame = CGRectMake(0 , 0, width, 35);
        }else if (self.design == SetBtnContentLeftAndRight) {
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width/3.0);
                make.height.mas_equalTo(height-25);
                make.top.mas_equalTo(self).offset(10);
                make.left.mas_equalTo(self).offset(5);
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.imageView.mas_right);
                make.width.mas_equalTo(@(width/3.0*2));
                make.top.mas_equalTo(self);
                make.height.mas_equalTo(@(height));
            }];
            self.titleLabel.textAlignment =NSTextAlignmentLeft;
        }
        
    }
}

/**
 *  Set red dot item
 */
- (void)setItem:(UITabBarItem *)item {
    self.badgeView.badgeValue = item.badgeValue;
    self.badgeView.badgeColor = item.badgeColor;
}

/**
 *  getter
 */
- (CYBadgeView *)badgeView {
    if (!_badgeView) {
        CYBadgeView * badgeView = [[CYBadgeView alloc] init];
        _badgeView = badgeView;
        [self addSubview:badgeView];
    }
    return _badgeView;
}


- (void)setHighlighted:(BOOL)highlighted{
}

@end
