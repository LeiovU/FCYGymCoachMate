//
//  FCYMethods.h
//  FCYPushAndPop01
//
//  Created by bwfstu on 16/2/29.
//  Copyright © 2016年 ancaifcy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface FCYMethods : NSObject

#pragma mark --读取文件URL
+(NSURL *)getURLWithName:(NSString *)name;

#pragma mark --播放短音频
/*使用步骤*/
/*#import <AVFoundation/AVFoundation.h>*/
+(void)playShortSoundWithName:(NSString *)soundName;


#pragma mark -- 跳转页面时候的效果动画
/**＊＊＊＊＊＊使用步骤＊＊＊＊＊＊＊＊＊＊*/
/***1.添加QuartzCore.framework (包) ***/
/***2.导入头文件#import <QuartzCore/QuartzCore.h>***/

@end
typedef enum
{
    FCYTransitionAnimationTypeCameraIris,
    //相机
    FCYTransitionAnimationTypeCube,
    //立方体
    FCYTransitionAnimationTypeFade,
    //淡入
    FCYTransitionAnimationTypeMoveIn,
    //移入
    FCYTransitionAnimationTypeOglFlip,
    //翻转
    FCYTransitionAnimationTypePageCurl,
    //翻去一页
    FCYTransitionAnimationTypePageUnCurl,
    //添上一页
    FCYTransitionAnimationTypePush,
    //平移
    FCYTransitionAnimationTypeReveal,
    //移走
    FCYTransitionAnimationTypeRippleEffect,
    FCYTransitionAnimationTypeSuckEffect
}FCYTransitionAnimationType;

/**动画方向*/
typedef enum
{
    FCYTransitionAnimationTowardFromLeft,
    FCYTransitionAnimationTowardFromRight,
    FCYTransitionAnimationTowardFromTop,
    FCYTransitionAnimationTowardFromBottom
}FCYTransitionAnimationToward;

@interface UIView (FCYTransitionAnimation)

//为当前视图添加切换的动画效果
//参数是动画类型和方向
//如果要切换两个视图，应将动画添加到父视图
- (void)setTransitionAnimationType:(FCYTransitionAnimationType)transtionAnimationType toward:(FCYTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration;

@end
#pragma mark -- 生成二维码

@interface QRCodeGenerator : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;

@end











