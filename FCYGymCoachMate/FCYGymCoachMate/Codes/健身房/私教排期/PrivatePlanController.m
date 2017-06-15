//
//  PrivatePlanController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/17.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "PrivatePlanController.h"
#import "PrivatePlanCell.h"
#import "PlanModel.h"

#import "CYTabBarController.h"
#import "PrivateScheduleController.h"

#import "AddAnimate.h"

@interface PrivatePlanController () <UITableViewDelegate,UITableViewDataSource,PlusAnimateDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation PrivatePlanController

#pragma mark -- 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = Back_Color;
        _tableView = tableView;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"私教排期";
    
    // 导航栏右侧
    [self createNavigationItemsWithTitle:nil andWithImage:[UIImage imageNamed:@"sj_01"] andWithType:NO andWithTag:Private_Schedule_Tag];
    
    
    [self.view addSubview:self.tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame  = CGRectMake(kScreenWidth-80, kScreenHeight-180, 60, 60);
    [button setImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(showAnimateView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

#pragma mark -- 导航栏按钮
-(void)onBarButtonClick:(UIButton *)sender {
    if (sender.tag == [Private_Schedule_Tag integerValue]) {
        PrivateScheduleController *schVC = [[PrivateScheduleController alloc]init];
        [self.navigationController pushViewController:schVC animated:YES];
        
    }else if (sender.tag == [Back_Tag integerValue]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 弹出动画
-(void)showAnimateView:(UIButton *)sender {
    AddAnimate *animate = [AddAnimate showPlusAnimateWithView:sender];
    animate.delegate = self;
}

// delegate
-(void)didSelectBtnWithTag:(NSInteger)tag {
    NSLog(@"%ld",tag);
}


#pragma mark -- tableview 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
   PrivatePlanCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PrivatePlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.indexPath = indexPath;
    
    
    // mvc 设置 cell
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 199/3.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20/3.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 跳转 传入 model 数据 到下个页面
    
    
    
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
