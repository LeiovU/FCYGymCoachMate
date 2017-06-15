//
//  CoursePlanController.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/6/13.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "CoursePlanController.h"
#import "MemberDetailsController.h"
#import "PlanCell.h"

@interface CoursePlanController () <UITableViewDelegate,UITableViewDataSource,moveDelegate>

@property (nonatomic,strong) UILabel *dateLabel;  //  日期


@property (nonatomic,strong) UIImageView *iconView;  // 头像
@property (nonatomic,strong) UIButton *memberName;  // 会员名称
@property (nonatomic,strong) UILabel *phoneNum;   //手机号
@property (nonatomic,strong) UILabel *remark;    // 备注
@property (nonatomic,strong) UILabel *reaminder;  // 剩余次数
@property (nonatomic,strong) UIButton *arrowBtn;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) CGRect rectCell;

@end

@implementation CoursePlanController {
    NSInteger rowCount;
    CGFloat keyboardH; // 键盘高度
    CGFloat _moveHeight; // 要移动的距离
}

#pragma mark -- 懒加载
-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2.0, 40)];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _dateLabel;
}

-(UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.image = [UIImage imageNamed:@"pic"];
    }
    return _iconView;
}

-(UIButton *)memberName {
    if (!_memberName) {
        _memberName = [UIButton buttonWithType:UIButtonTypeCustom];
        [_memberName setTitle:@"会员名称" forState:UIControlStateNormal];
        [_memberName setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_memberName setTitleColor:Font_Mid_Color forState:UIControlStateNormal];
        _memberName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _memberName;
}

-(UILabel *)phoneNum {
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc]init];
        _phoneNum.text = @"手机 130000000";
        _phoneNum.textColor = Font_Week_Color;
        _phoneNum.font = [UIFont systemFontOfSize:12];
    }
    return _phoneNum;
}

-(UILabel *)remark {
    if (!_remark) {
        _remark = [[UILabel alloc]init];
        _remark.text = @"备注 暂无";
        _remark.textColor = Font_Week_Color;
        _remark.font = [UIFont systemFontOfSize:12];
    }
    return _remark;
}

-(UILabel *)reaminder {
    if (!_reaminder) {
        _reaminder = [[UILabel alloc]init];
        _reaminder.text = @"剩余：8次";
        _reaminder.textColor = Font_Mid_Color;
        _reaminder.font = [UIFont systemFontOfSize:12];
    }
    return _reaminder;
}

-(UIButton *)arrowBtn {
    if (!_arrowBtn) {
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowBtn setImage:[UIImage imageNamed:@"sj_08"] forState:UIControlStateNormal];
        [_arrowBtn addTarget:self action:@selector(jumpToMemberDetails:) forControlEvents:UIControlEventTouchUpInside];
        [_arrowBtn setBackgroundColor:[UIColor clearColor]];
        _arrowBtn.adjustsImageWhenHighlighted = NO; // 设置button高亮颜色无
    }
    return _arrowBtn;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90+45, kScreenWidth, kScreenHeight-64-45-90) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat width = kScreenWidth/3.0;
    
    self.iconView.frame = CGRectMake(5, 5, Icon_Radius, Icon_Radius);
    [_memberName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(10);
        make.top.mas_equalTo(self.iconView.mas_top);
        make.width.mas_equalTo(@(width));
        make.height.mas_equalTo(@(Icon_Radius/2.0));
    }];
    [_memberName setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [_memberName setImageEdgeInsets:UIEdgeInsetsMake(0, width-10, 0, 0)];
    
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.memberName.mas_left);
        make.top.mas_equalTo(self.memberName.mas_bottom);
        make.width.mas_equalTo(@(width));
        make.height.mas_equalTo(@(Icon_Radius/4.0));
    }];
    
    [self.remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.memberName.mas_left);
        make.top.mas_equalTo(self.phoneNum.mas_bottom);
        make.width.mas_equalTo(@(width));
        make.height.mas_equalTo(@(Icon_Radius/4.0));
    }];
    
    [self.reaminder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(self.iconView.mas_top);
        make.width.mas_equalTo(@(kScreenWidth/5.0));
        make.height.mas_equalTo(@(Icon_Radius/4.0));
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.reaminder.mas_right).offset(-10);
        make.top.mas_equalTo(self.phoneNum.mas_top);
        make.width.mas_equalTo(@(30));
        make.height.mas_equalTo(@(30));
    }];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"课程安排";
    self.view.backgroundColor = Back_Color;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    rowCount = 1;
    
    [self setupSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Do any additional setup after loading the view.
}

#pragma mark -- 键盘
-(void)keyboardWillShow:(NSNotification *)note {
    
    CGRect keyBoardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardH = keyBoardRect.size.height;
    
    float textY = _rectCell.origin.y;//cell距离顶部的距离
    float bottomY = self.view.bounds.size.height - textY-80;//要编辑的textField离底部的距离
    
    if (bottomY >= keyboardH) {
        return;
    }
    
    _moveHeight = keyboardH-bottomY+10;  // 要移动的距离
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.view.frame = CGRectMake(0, (0-_moveHeight),  self.view.bounds.size.width, self.view.bounds.size.height);
        
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)note {
    [UIView animateWithDuration:0.5f animations:^{
        
        self.view.frame = CGRectMake(0, 64,  self.view.bounds.size.width, self.view.bounds.size.height);
        
    }];
}


#pragma mark -- cell  delegate
-(void)cellWith:(NSIndexPath *)index {
    CGRect rectInTableView = [_tableView rectForRowAtIndexPath:index];
    CGRect rectInSuperview = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
    
    _rectCell = rectInSuperview;
}

-(void)setupSubviews {
    // 背景1
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [self.view addSubview:backView1];
    backView1.backgroundColor = [UIColor greenColor];
    
    [backView1 addSubview:self.dateLabel];
    
    // 背景2
    UIView *backView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 90)];
    backView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView2];
    
    [backView2 addSubview:self.iconView];
    [backView2 addSubview:self.memberName];
    [backView2 addSubview:self.phoneNum];
    [backView2 addSubview:self.remark];
    [backView2 addSubview:self.reaminder];
    [backView2 addSubview:self.arrowBtn];
    
    [self.view addSubview:self.tableView];
    
    
}



#pragma mark -- 跳转到会员详情页面
-(void)jumpToMemberDetails:(UIButton *)sender {
//    self.arrowBtn.highlighted = NO;
    MemberDetailsController *detailVC = [[MemberDetailsController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}



#pragma mark -- delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"planCell";
    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2.0, 40)];
        label.text = @" 训练计划";
        label.textColor = [UIColor orangeColor];
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        button.frame = CGRectMake(kScreenWidth-40, 5, 40, 40);
        [button addTarget:self action:@selector(addMorePlanCell) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        return view;
    }
    return nil;
}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    rowCount--;
    [tableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark --  添加cell 
-(void)addMorePlanCell {
    rowCount++;
    
    [self.tableView reloadData];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
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
