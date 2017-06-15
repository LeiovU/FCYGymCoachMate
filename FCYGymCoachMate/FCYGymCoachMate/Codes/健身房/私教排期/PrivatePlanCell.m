//
//  PrivatePlanCell.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/17.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "PrivatePlanCell.h"


@interface PrivatePlanCell ()

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *category;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@end



@implementation PrivatePlanCell

-(UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        
    }
    return _imageV;
}

-(UILabel *)category {
    if (!_category) {
        _category = [[UILabel alloc]init];
        _category.adjustsFontSizeToFitWidth = YES;
        _category.textAlignment = NSTextAlignmentLeft;
        _category.font = [UIFont systemFontOfSize:18];
        _category.textColor = Font_Color;
    }
    return _category;
}

-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont systemFontOfSize:15];
        _dateLabel.textColor = Font_Week_Color;
    }
    return _dateLabel;
}

-(UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = Font_Week_Color;
    }
    return _timeLabel;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //cell的右边有一个小箭头，距离右边有十几像素
        [self createView];
        
    }
    return self;
}

-(void)createView {
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.category];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.timeLabel];
}


-(void)setModel:(PlanModel *)model {
    _model = model;
    
    // 设置图片、名称之类
    
}


-(void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (indexPath.row == 0) {
        _imageV.image = [UIImage imageNamed:@"sj_02"];
        _category.text = @"工作排期";
        _dateLabel.text = @"2017-05-01 至 2017-05-31";
        _timeLabel.text = @"9:30-21:00";
    }else if (indexPath.row == 1) {
        _imageV.image = [UIImage imageNamed:@"sj_03"];
        _category.text = @"休息时间";
        _dateLabel.text = @"2017-05-01 至 2017-05-31";
        _timeLabel.text = @"每周一";
    }
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marginX = 51/3.0;
    CGFloat marginY = 53/3.0;
    CGFloat width = self.frame.size.height-marginY*2;
    
    self.imageV.frame = CGRectMake(marginX, marginY, width, width);
    self.category.frame = CGRectMake(marginX+width+20, 0, self.frame.size.width/2.0, 25);
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.category);
        make.top.mas_equalTo (self.category.mas_bottom);
        make.width.mas_equalTo(self.category);
        make.height.mas_equalTo(@20);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLabel);
        make.top.mas_equalTo(self.dateLabel.mas_bottom);
        make.width.mas_equalTo(self.dateLabel);
        make.height.mas_equalTo(@20);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
