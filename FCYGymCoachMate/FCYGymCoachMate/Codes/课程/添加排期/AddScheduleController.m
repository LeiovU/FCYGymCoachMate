//
//  AddScheduleController.m
//  FCYGymCoachMate
//
//  Created by AsiaInfo on 2017/6/15.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "AddScheduleController.h"
#import "ZJScrollPageView.h"

#import "ScheduleController.h"
#import "SetRestController.h"

@interface AddScheduleController () <ZJScrollPageViewDelegate>

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) ZJScrollPageView *scrollPageView;
@property (nonatomic,strong) NSArray<NSString *> *titles;
@property (nonatomic,strong) NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;

@end

@implementation AddScheduleController

#pragma mark -- 懒加载
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"添加排期";
    
    
    [self createSubViews];
    
    
    // Do any additional setup after loading the view.
}



-(void)createSubViews {
    
    [self.view addSubview:self.contentView];
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    // 显示遮盖
    style.showLine = YES;
    /// 设置滚动条高度
    style.segmentHeight = 40;
    // 开始滚动就改变标题
    style.adjustTitleWhenBeginDrag = YES;
    // 当标题(和图片)宽度总和小于ZJScrollPageView的宽度的时候, 标题会自适应宽度
    style.autoAdjustTitlesWidth = YES;
    
    style.scrollLineColor = [@"#3d72fe" colorValue];
    style.scrollLineHeight = 2;
    style.titleMargin = 0;  // 标题的间距
    
    
    
    // 初始化
    CGRect scrollPageViewFrame= CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    
    self.titles = @[@"添加排期",@"设置休息"];
    
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc]initWithFrame:scrollPageViewFrame segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    
    [self.contentView addSubview:self.scrollPageView];
}


#pragma mark --  代理
-(NSInteger)numberOfChildViewControllers {
    return _titles.count;
}

-(UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    if (index == 0) {
        ScheduleController *schedule = (ScheduleController *)reuseViewController;
        if (!schedule) {
            schedule = [[ScheduleController alloc]init];
        }
        return schedule;
    }else {
        SetRestController *restVC = (SetRestController *)reuseViewController;
        if (!restVC) {
            restVC = [[SetRestController alloc]init];
        }
        return restVC;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
