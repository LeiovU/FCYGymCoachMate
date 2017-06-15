//
//  SlideFormScrollView.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/5.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "SlideFormScrollView.h"
#import "SlideFormCell.h"

#import "DrawForm.h"

@interface SlideFormScrollView () <UIScrollViewDelegate>
{
    NSArray *timeArray;
}

//@property (nonatomic,strong)DrawForm *formView;

@property (nonatomic,strong) UIView *contentView1;
@property (nonatomic,strong) UIView *contentView2;
@property (nonatomic,strong) UIView *contentView3;

@end

@implementation SlideFormScrollView

#pragma mark -- 懒加载
-(UIView *)contentView1 {
    if (!_contentView1) {
        _contentView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.width/8.0*1.5*24)];
        _contentView1.backgroundColor = [UIColor whiteColor];
    }
    return _contentView1;
}
-(UIView *)contentView2 {
    if (!_contentView2) {
        _contentView2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.frame.size.width/8.0*1.5*24)];
        _contentView2.backgroundColor = [UIColor whiteColor];
    }
    return _contentView2;
}
-(UIView *)contentView3 {
    if (!_contentView3) {
        _contentView3 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, self.frame.size.width/8.0*1.5*24)];
        _contentView3.backgroundColor = [UIColor whiteColor];
    }
    return _contentView3;
}


-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = YES;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        
        self.contentSize = CGSizeMake(self.bounds.size.width*3, self.frame.size.width/8.0*1.5*24+10);
//        [self setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO];
        
        timeArray = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00"];
        
        [self setupContentView];
        [self setupFormViewOnView:self.contentView1];
        [self setupFormViewOnView:self.contentView2];
        [self setupFormViewOnView:self.contentView3];
        
    }
    return self;
}
-(void)setupContentView {
    [self addSubview:self.contentView1];
    [self addSubview:self.contentView2];
    [self addSubview:self.contentView3];
}

-(void)setupFormViewOnView:(UIView *)contentView {
    
    DrawForm *formView = [[DrawForm alloc]initWithFrame:CGRectMake(kScreenWidth/8.0, 0, kScreenWidth-kScreenWidth/8.0, self.frame.size.width/8.0*1.5*24)];
    
    [contentView addSubview:formView];
    
    // 画时间坐标
    //画竖直的坐标
    for (int i = 0 ; i<timeArray.count; i++) {
        UILabel * VerticalDataArrayLabel = [[UILabel alloc]init];
        [contentView addSubview:VerticalDataArrayLabel];
        
        float y;
        if (i == 0) {
            y = 0;
        }else {
            y = i*(self.frame.size.width/8.0*1.5) - 5;
        }
        
        VerticalDataArrayLabel.textAlignment=NSTextAlignmentCenter;
        [VerticalDataArrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).offset(y);
            make.left.equalTo(contentView).offset(0);
            make.height.equalTo(@(10));
            make.width.equalTo(@(kScreenWidth/8.0));
        }];
        VerticalDataArrayLabel.font = [UIFont systemFontOfSize:12];
        VerticalDataArrayLabel.text = timeArray[i];
        
    }
    
}



#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (scrollView != self) {
//        return;
//    }
    
    // 向右滑动
    if (scrollView.contentOffset.x < self.bounds.size.width) {
        
    }
    
    // 向左滑动
    if (scrollView.contentOffset.x > self.bounds.size.width) {
        
    }
    
    
    
//     [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO]; // 然后变换位置
    
}






@end





















