//
//  SetRestController.m
//  FCYGymCoachMate
//
//  Created by AsiaInfo on 2017/6/15.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "SetRestController.h"

@interface SetRestController ()

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIScrollView *scroll;

@property (nonatomic,strong) UIButton *startDate;  // 开始日期
@property (nonatomic,strong) UIButton *startTime; // 开始时间
@property (nonatomic,strong) UIButton *endTime;  // 结束时间

@end

@implementation SetRestController

#pragma mark -- 懒加载
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _contentView.backgroundColor = Back_Color;
    }
    return _contentView;
}

-(UIButton *)startDate {
    if (!_startDate) {
        _startDate = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startDate setTitle:[self getStringFromToday] forState:UIControlStateNormal];
        [_startDate setTitleColor:Font_Mid_Color forState:UIControlStateNormal];
        _startDate.titleLabel.font = [UIFont systemFontOfSize:14];
        _startDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; //文字居右
        _startDate.tag = 1;
        [_startDate addTarget:self action:@selector(showPickerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startDate;
}

-(UIButton *)startTime {
    if (!_startTime) {
        _startTime = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startTime setTitle:@"00:00" forState:UIControlStateNormal];
        [_startTime setTitleColor:Font_Mid_Color forState:UIControlStateNormal];
        _startTime.titleLabel.font = [UIFont systemFontOfSize:14];
        _startTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _startTime.tag = 2;
        [_startTime addTarget:self action:@selector(showPickerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startTime;
}

-(UIButton *)endTime {
    if (!_endTime) {
        _endTime = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endTime setTitle:@"23:59" forState:UIControlStateNormal];
        [_endTime setTitleColor:Font_Mid_Color forState:UIControlStateNormal];
        _endTime.titleLabel.font = [UIFont systemFontOfSize:14];
        _endTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _endTime.tag = 3;
        [_endTime addTarget:self action:@selector(showPickerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endTime;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubviews];
    
    // Do any additional setup after loading the view.
}

-(void)createSubviews {
    [self.view addSubview:self.contentView];
    
    UIView *back1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    back1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:back1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4.0, 50)];
    label1.text = @" 开始日期";
    [back1 addSubview:label1];
    
    [back1 addSubview:self.startDate];
    self.startDate.frame = CGRectMake(kScreenWidth/4.0*3-10, 0, kScreenWidth/4.0, 50);
    
    UIView *back2 = [[UIView alloc]initWithFrame:CGRectMake(0, 51, kScreenWidth, 50)];
    back2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:back2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4.0, 50)];
    label2.text = @" 开始时间";
    [back2 addSubview:label2];
    
    [back2 addSubview:self.startTime];
    self.startTime.frame = CGRectMake(kScreenWidth/4.0*3-10, 0, kScreenWidth/4.0, 50);
    
    UIView *back3 = [[UIView alloc]initWithFrame:CGRectMake(0, 102, kScreenWidth, 50)];
    back3.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:back3];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4.0, 50)];
    label3.text = @" 开始日期";
    [back3 addSubview:label3];
    
    [back3 addSubview:self.endTime];
    self.endTime.frame = CGRectMake(kScreenWidth/4.0*3-10, 0, kScreenWidth/4.0, 50);
    
}


#pragma mark -- 弹出选择框
-(void)showPickerClick:(UIButton *)sender {
    
}


-(NSString *)getStringFromToday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    
    return currentDateString;
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
