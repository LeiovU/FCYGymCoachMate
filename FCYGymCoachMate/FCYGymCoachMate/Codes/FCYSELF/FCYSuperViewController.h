//
//  FCYSuperViewController.h
//  FCYPushAndPop01
//
//  Created by bwfstu on 16/2/29.
//  Copyright © 2016年 ancaifcy. All rights reserved.
//

//头文件区
#import <UIKit/UIKit.h>
#import "FCYMethods.h"
//#import <PureLayout.h>
//#import <pop/POP.h>

#define FCYNUM_GUIDE 5


//宏定义区
#define FCYSIZE [[UIScreen mainScreen]bounds].size

#define FCYCGRECTMAKE2(x,y,w,h) CGRectMake(x, y, w/320.0*FCYSIZE.width, h/480.0*FCYSIZE.height)
#define FCYCGRECTMAKE3(x,y,w,h) CGRectMake(x/320.0*FCYSIZE.width, y, w/320.0*FCYSIZE.width, h/480.0*FCYSIZE.height)
#define FCYCGRECTMAKE4(x,y,w,h) CGRectMake(x/320.0*FCYSIZE.width, y/480.0*FCYSIZE.height, w/320.0*FCYSIZE.width, h/480.0*FCYSIZE.height)

#define IS_iOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f



@interface FCYSuperViewController : UIViewController

#pragma mark -- 方法区

typedef enum
{
    Tap = 1,
    LongPress,   //长按
    Swipe,       //滑动
    Pan,        //拖动
    Rotation,   //旋转
    Pinch       //捏合
    
}FCYTypeGR;
#pragma mark  -- 创建手势
-(void)createOneGRWithType:(FCYTypeGR)typeGR andAddView:(UIView *)view;
-(void)TapGRClick:(UITapGestureRecognizer *)sender;
-(void)SwipeGRClick:(UISwipeGestureRecognizer *)sender;  //左滑


#pragma mark -- 创建导航栏 左右Button
-(void)createNavigationItemsWithTitle:(NSString *)title andWithImage:(UIImage *)image andWithType:(BOOL)type andWithTag:(NSString *)tag;
-(void)onBarButtonClick:(UIButton *)sender;   //点击事件

#pragma mark -- alert
//-(void)alertWithMessage:(NSString *)msg;

@end


