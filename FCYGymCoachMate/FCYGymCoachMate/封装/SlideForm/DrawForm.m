//
//  DrawForm.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/5.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "DrawForm.h"

@interface DrawForm ()

@property (nonatomic,assign)float width;
@property (nonatomic,assign)float height;

#define PieceWidth self.frame.size.width/7.0
#define PieceHeight self.frame.size.width/7.0*1.5

@end


@implementation DrawForm

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        for (int i = 0; i<25; i++) {
            [linePath moveToPoint:CGPointMake(0, i*PieceHeight)];
            [linePath addLineToPoint:CGPointMake(self.frame.size.width, i*PieceHeight)];
            
            lineLayer.lineWidth = 1.0;
            lineLayer.strokeColor = [UIColor lightGrayColor].CGColor;
            lineLayer.path = linePath.CGPath;
            lineLayer.lineCap = kCALineCapRound;
            lineLayer.fillColor = nil;
            [self.layer addSublayer:lineLayer];
        }
        
        for (int i = 0; i<8; i++) {
            [linePath moveToPoint:CGPointMake(i*PieceWidth, 0)];
            [linePath addLineToPoint:CGPointMake(i*PieceWidth, self.frame.size.height)];
            
            lineLayer.lineWidth = 1.0;
            lineLayer.strokeColor = [UIColor lightGrayColor].CGColor;
            lineLayer.path = linePath.CGPath;
            lineLayer.lineCap = kCALineCapRound;
            lineLayer.fillColor = nil;
            [self.layer addSublayer:lineLayer];
            
        }
        
        
    }
    return self;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint locaion = [touch locationInView:self];
    NSLog(@"%f,%f",locaion.x,locaion.y);
    
    int a = (int)floor(locaion.x);
    int b = (int)ceilf(PieceWidth);
    
    int m = (int)floor(locaion.y);
    int n = (int)ceilf(PieceHeight);
    
    CGPoint point;
    point.x = (a/b)*PieceWidth;
    point.y = (m/n)*PieceHeight;
    NSLog(@"宽:%f %f,%f",PieceWidth,point.x,point.y);
    NSLog(@"%d",(int)floor(point.x));
    
    [self drawUIWithPoint:point];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:point.x] forKey:@"touchPointX"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:point.y] forKey:@"touchPointY"];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"skipTo" object:nil userInfo:nil];
    
}

-(void)drawUIWithPoint:(CGPoint)point {
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:point];
    [linePath addLineToPoint:CGPointMake(point.x+PieceWidth, point.y)];
    [linePath addLineToPoint:CGPointMake(point.x+PieceWidth, point.y+PieceHeight)];
    [linePath addLineToPoint:CGPointMake(point.x, point.y+PieceHeight)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1.0;
    lineLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.fillColor = [UIColor greenColor].CGColor;
    lineLayer.strokeStart = 0;
    lineLayer.strokeEnd = 1;
    [self.layer addSublayer:lineLayer];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, PieceWidth, PieceHeight)];
    label.text = @"会员";
    label.textColor = [UIColor redColor];
    [self addSubview:label];

}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    
//}

@end









