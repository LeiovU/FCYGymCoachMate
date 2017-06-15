//
//  MemberDetailsController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/16.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "MemberDetailsController.h"
#import "ZJScrollPageView.h"

#import "BaseInfoController.h"
#import "ClassRecordController.h"
#import "PhysicalTestController.h"

@interface MemberDetailsController () <ZJScrollPageViewDelegate>

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) ZJScrollPageView *scrollPageView;
@property (nonatomic,strong) NSArray<NSString *> *titles;
@property (nonatomic,strong) NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;

@end

@implementation MemberDetailsController

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
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createSubViews];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)createSubViews {
    
    [self.view addSubview:self.contentView];
    
    // 一
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, 200)];
    backView1.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:backView1];
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc]init];
    // 显示遮盖
    style.showLine = YES;
    /// 设置滚动条高度
    style.segmentHeight = 40;
    // 开始滚动就改变标题
    style.adjustTitleWhenBeginDrag = YES;
    // 当标题(和图片)宽度总和小于ZJScrollPageView的宽度的时候, 标题会自适应宽度
    style.autoAdjustTitlesWidth = YES;
    
    style.titleMargin = 0;
    
    

    // 初始化
    CGRect scrollPageViewFrame= CGRectMake(0, 200, kScreenWidth, kScreenHeight-200);
    
    self.titles = @[@"基本信息",
                    @"上课记录",
                    @"体侧信息"];
    
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc]initWithFrame:scrollPageViewFrame segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    
    [self.contentView addSubview:self.scrollPageView];
}


#pragma  代理
-(NSInteger)numberOfChildViewControllers {
    return _titles.count;
}


-(UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    if (index == 0) {
        BaseInfoController *infoVC = (BaseInfoController *)reuseViewController;
        if (!infoVC) {
            infoVC = [[BaseInfoController alloc]init];
            
        }
        return infoVC;
    }else if (index == 1) {
        ClassRecordController *recordVC = (ClassRecordController *)reuseViewController;
        if (!recordVC) {
            recordVC = [[ClassRecordController alloc]init];
            recordVC.view.backgroundColor = [UIColor yellowColor];
        }
        return recordVC;
    }else {
        PhysicalTestController *testVC = (PhysicalTestController *)reuseViewController;
        if (!testVC) {
            testVC = [[PhysicalTestController alloc]init];
            testVC.view.backgroundColor = [UIColor blueColor];
        }
        return  testVC;
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
