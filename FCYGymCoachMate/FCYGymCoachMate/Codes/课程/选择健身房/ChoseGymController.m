//
//  ChoseGymController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/3.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "ChoseGymController.h"

@interface ChoseGymController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableVew;
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ChoseGymController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNaviViews];
    
    // 数据源
    [self prepareData];
    
    // 添加子视图
    [self addViews];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)setNaviViews {
    UIView *naviBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    naviBackView.backgroundColor = RGB(33, 192, 174);
    
    [self.view addSubview:naviBackView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 24, 50, 40);
    [button setTitle:@"❌" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [naviBackView addSubview:button];
    
    
}

-(void)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)prepareData {
    _dataSource = [NSMutableArray array];
    
    // 网络请求数据
    
    
    
}

-(void)addViews {
    [self.view addSubview:self.tableVew];
}

#pragma mark -- 懒加载
-(UITableView *)tableVew {
    if (!_tableVew) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableVew = tableView;
    }
    return _tableVew;
}


#pragma mark -- 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataSource.count > 0) {
        return _dataSource.count;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    
    // 先直接写
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"11";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 点击 ，cell上的对号 就不隐藏，字体颜色变化
    
    self.block(@"标题");
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


-(void)returnTitle:(TitleChoseBlock)block {
    self.block = block;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











