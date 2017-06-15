//
//  Public.h
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/3.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#ifndef Public_h
#define Public_h

//  适配 rect
#define FCYWIDTH_SCALE kScreenWidth/320
#define FCYRECT(x,y,w,h) CGRectMake(x*FCYWIDTH_SCALE,y*FCYWIDTH_SCALE,w*FCYWIDTH_SCALE,h*FCYWIDTH_SCALE)

// 2.获得RGB颜色
#define RGBA(r, g, b, a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)         RGBA(r, g, b, 1.0f)
#define navigationBarColor RGB(33, 192, 174)
#define RGBF(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1.0]

// 屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define Back_Tag @"111"
#define HomePage_Tag @"222"
#define SwitchGym_Tag @"333"
#define Private_Schedule_Tag @"444"
#define Private_Schedule_Add @"445"
#define Private_Schedule_Back @"446"

#define Tab_Color [@"#e4e4e7" colorValue]  // tabbar 颜色
#define Nav_Color [@"#303A52" colorValue] // 和导航栏背景色相同
#define Back_Color [@"#f2f2f2" colorValue] // 背景色
#define Icon_Radius 229/3    // 头像直径
#define Font_Name @"微软雅黑"  // 字体
#define Font_Color [@"#333333" colorValue]  // 字体颜色
#define Font_Mid_Color [@"#666666" colorValue] 
#define Font_Week_Color [@"#999999" colorValue] // 周末字体颜色
#define Font_Red_Color [@"#fe4d3d" colorValue]

#define WeekDay_H 60   // 今 右边日历高度


#define isLogin @"isLogin"   // 是否登录




#endif /* Public_h */



