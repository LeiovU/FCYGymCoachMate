//
//  AddAnimate.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/17.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "AddAnimate.h"
#define bl [[UIScreen mainScreen]bounds].size.width/375

@interface AddAnimate ()

// 点击消失的按钮
@property (nonatomic,strong) UIButton *rightBtn;
//other function button
@property (strong , nonatomic) NSMutableArray* BtnItem;
@property (strong , nonatomic) NSMutableArray* BtnItemTitle;
/** rect */
@property (nonatomic,assign) CGRect rect;


@end


@implementation AddAnimate

/**
 * show
 */
+(AddAnimate *)showPlusAnimateWithView:(UIView *)view {
    AddAnimate *animateView = [[AddAnimate alloc]init];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:animateView];
    
    // 将rect从view中转换到当前视图中，返回在当前视图中的rect
    CGRect rect = [animateView convertRect:view.frame fromView:view.superview];
    rect.origin.y += 5;
    rect.origin.x += (rect.size.width-rect.size.height)/2;
    rect.size.width = rect.size.height;
    animateView.rect = rect;
    
    // 添加按钮
    [animateView createBtnImageName:@"post_animate_camera" title:@"yiyiyi" tag:1];
    [animateView createBtnImageName:@"post_animate_camera" title:@"weewwee" tag:2];
    
    [animateView createRightBtnImgName:@"post_animate_add" tag:3];
    
    
    [animateView animateBegin];
    
    return animateView;
}


-(instancetype)init {
    self = [super init];
    if (self)
    {
        self.frame = [[UIScreen mainScreen]bounds];
        self.backgroundColor =[[UIColor whiteColor]colorWithAlphaComponent:0.3];
        
        
        //  添加毛玻璃效果
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [visualEffectView setFrame:self.bounds];
        [self addSubview:visualEffectView];
        
    }
    return self;
}


-(void)createBtnImageName:(NSString *)imageName title:(NSString *)title tag:(NSInteger)tag {
    if (_BtnItem.count >= 2)  return;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:self.rect];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self.BtnItem addObject:btn];
    [self.BtnItemTitle addObject:[self createLabelTitle:title]];
    
}

-(void)createRightBtnImgName:(NSString *)imageName tag:(NSInteger)tag {
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = self.rect;
    [_rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.tag = tag;
    [self addSubview:_rightBtn];
    
}

// 创建图片左边的label
-(UILabel *)createLabelTitle:(NSString *)title {
    UILabel * lab = [[UILabel alloc]init];
    lab.textColor = RGBA(240, 240, 240, 1);
    lab.font = [UIFont italicSystemFontOfSize:13.5*bl];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.backgroundColor = [UIColor redColor];
    lab.text = title;
    [self addSubview:lab];
    return lab;
}


#pragma mark -- 点击事件
-(void)btnClick:(UIButton *)sender {
    [self.delegate didSelectBtnWithTag:sender.tag];
    [self removeFromSuperview];
}

-(void)cancelAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        _rightBtn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //move
        int n = (int)_BtnItem.count;
        for (int i = n-1; i>=0; i--){
            UIButton *btn = _BtnItem[i];
            [UIButton animateWithDuration:0.2 delay:0.1*(n-i) options:UIViewAnimationOptionTransitionCurlDown animations:^{
                btn.center = CGPointMake(kScreenWidth-50, kScreenHeight-150);
                btn.transform = CGAffineTransformMakeScale(1, 1);
//                btn.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
                
                UILabel * lab = (UILabel *)_BtnItemTitle[i];
                [lab removeFromSuperview];
            } completion:^(BOOL finished) {
                [btn removeFromSuperview];
                if (i==0) {
                    [self removeFromSuperview];
                }
            }];
        }

    }];
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelAnimation];
}



#pragma mark -- 弹出动画效果
-(void)animateBegin {
    //centet button rotation  抖动效果
    [UIView animateWithDuration:0.2 animations:^{
        _rightBtn.transform = CGAffineTransformMakeRotation(-M_PI_4-M_LOG10E);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            _rightBtn.transform = CGAffineTransformMakeRotation(-M_PI_4+M_LOG10E);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                _rightBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
            }];
        }];
    }];
    
    
    __block int i = 0,k = 0;
    for (UIView *btn in _BtnItem) {
        [UIView animateWithDuration:0.7 delay:0.12*i options:UIViewAnimationOptionTransitionNone animations:^{
            btn.center = CGPointMake(kScreenWidth-50, kScreenHeight-220-80*i++);
        } completion:^(BOOL finished) {
            UILabel * lab = (UILabel *)_BtnItemTitle[k];
            lab.frame = CGRectMake(kScreenWidth/2.0, kScreenHeight-230-80*k++, 100, 30);
        }];
        
    }
    
}


#pragma mark -- 懒加载
- (NSMutableArray *)BtnItem{
    if (!_BtnItem) {
        _BtnItem = [NSMutableArray array];
    }
    return _BtnItem;
}
- (NSMutableArray *)BtnItemTitle{
    if (!_BtnItemTitle) {
        _BtnItemTitle = [NSMutableArray array];
    }
    return _BtnItemTitle;
}


@end














