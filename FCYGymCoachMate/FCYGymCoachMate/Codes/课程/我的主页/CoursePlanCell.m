//
//  CoursePlanCell.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/5/10.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "CoursePlanCell.h"

@implementation CoursePlanCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    
    
    
    
    
    //***********************高度自适应cell设置步骤************************
//    [self setupAutoHeightWithBottomView:nil bottomMargin:nil];
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
