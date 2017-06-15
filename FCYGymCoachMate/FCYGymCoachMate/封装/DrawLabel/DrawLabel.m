//
//  DrawLabel.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/8.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "DrawLabel.h"
#define kWidth self.frame.size.width
#define kHight self.frame.size.height

@interface DrawLabel ()
@property (nonatomic, strong)UIBezierPath *path;

@end


@implementation DrawLabel

-(instancetype)initWithFrame:(CGRect)frame fillColor:(UIColor *)fillClor titleLable:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.title = title;
        self.fillColor = fillClor;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self creatUIWithFillColor:fillClor titleLabel:title];
    }
    return self;
}

-(void)creatUIWithFillColor:(UIColor *)fillColor titleLabel:(NSString *)title {
    [self drawCircle];
    
    _titleLable = [[UILabel alloc]init];
    _titleLable.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _titleLable.text = title;
    _titleLable.font = [UIFont systemFontOfSize:16];
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.userInteractionEnabled = YES;
    
    [self addSubview:_titleLable];
    
}

-(void)drawRect:(CGRect)rect {
    UIColor *fillColor = self.fillColor;
    [fillColor setFill];
    [_path closePath];
    [_path fill];
}

-(void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

-(void)setLabelColor:(UIColor *)labelColor {
    _labelColor = labelColor;
    _titleLable.textColor = labelColor;
}


- (void)drawCircle{
    CGFloat radious = kHight/2.0;
    CGFloat width = kWidth - kHight;
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(radious, 0)];
    [_path addLineToPoint:CGPointMake(width + radious, 0)];
    [_path addArcWithCenter:CGPointMake(width +radious, radious) radius:radious startAngle:M_PI_2 * 3  endAngle:M_PI_2 clockwise:YES];
    [_path addLineToPoint:CGPointMake(radious, kHight)];
    [_path addArcWithCenter:CGPointMake(radious, radious) radius:radious startAngle:M_PI_2 endAngle:M_PI_2 *3 clockwise:YES];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = _path.CGPath;
    pathLayer.lineCap = kCALineCapRound;
    
    pathLayer.lineJoin = kCALineJoinRound;
    pathLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0;
    pathLayer.strokeStart = 0.0;
    pathLayer.strokeEnd = 1.0;
    
    [self.layer addSublayer:pathLayer];
    
}
@end



