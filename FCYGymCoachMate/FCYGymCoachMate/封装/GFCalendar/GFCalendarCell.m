//
//  GFCalendarCell.m
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import "GFCalendarCell.h"

@implementation GFCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.todayCircle];
        [self addSubview:self.todayLabel];
        [self addSubview:self.subTitle];
    }
    
    return self;
}

-(void)layoutSubviews {
    [self.todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX);
//        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.8);//在中心点网上一部分
        make.top.equalTo(self);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).multipliedBy(0.4);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayLabel.mas_bottom);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).multipliedBy(0.4);
//        make.centerX.equalTo(self.mas_centerX);
        
    }];
}


-(void)setTodayName:(NSString *)todayName {
    _todayName = todayName;
    _todayLabel.text = todayName;
}

- (UIView *)todayCircle {
    if (_todayCircle == nil) {
        _todayCircle = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.8 * self.bounds.size.height, 0.8 * self.bounds.size.height)];
        _todayCircle.center = CGPointMake(0.5 * self.bounds.size.width, 0.5 * self.bounds.size.height);
        _todayCircle.layer.cornerRadius = 0.5 * _todayCircle.frame.size.width;
    }
    return _todayCircle;
}

- (UILabel *)todayLabel {
    if (_todayLabel == nil) {
        _todayLabel = [[UILabel alloc]init];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        _todayLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _todayLabel.backgroundColor = [UIColor clearColor];
    }
    return _todayLabel;
}

-(UILabel *)subTitle {
    if (!_subTitle) {
        _subTitle = [[UILabel alloc]init];
        _subTitle.textAlignment = NSTextAlignmentCenter;
        _subTitle.font = [UIFont systemFontOfSize:14.0];
        _subTitle.backgroundColor = [UIColor clearColor];
    }
    return _subTitle;
}


@end
