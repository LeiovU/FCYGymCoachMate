//
//  AddAnimate.h
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/17.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

// 点击按钮协议
@protocol PlusAnimateDelegate <NSObject>

-(void)didSelectBtnWithTag:(NSInteger)tag;

@end


@interface AddAnimate : UIView

@property (nonatomic,assign)id<PlusAnimateDelegate> delegate;
//弹出动画view
+(AddAnimate *)showPlusAnimateWithView:(UIView *)view;

@end
