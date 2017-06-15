//
//  PlanCell.m
//  FCYGymCoachMate
//
//  Created by Fangcy on 2017/6/13.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "PlanCell.h"

@interface PlanCell () <UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField1;
@property (nonatomic,strong) UITextField *textField2;
@property (nonatomic,strong) UITextField *textField3;
@property (nonatomic,strong) UIButton *deleteBtn;

@end


@implementation PlanCell {
    NSString *_briefName;
    NSString *_num;
    NSString *_group;
}

-(UITextField *)textField1 {
    if (!_textField1) {
        _textField1 = [[UITextField alloc]init];
        _textField1.backgroundColor = [UIColor whiteColor];
        _textField1.placeholder = @"请输入动作名称";
        _textField1.textColor = [UIColor lightGrayColor];
        _textField1.adjustsFontSizeToFitWidth = YES;
        _textField1.keyboardType = UIKeyboardTypeDefault;
        _textField1.returnKeyType = UIReturnKeyNext;
        _textField1.delegate = self;
    }
    return _textField1;
}

-(UITextField *)textField2 {
    if (!_textField2) {
        _textField2 = [[UITextField alloc]init];
        _textField2.backgroundColor = [UIColor whiteColor];
        _textField2.placeholder = @"数量";
        _textField2.textColor = [UIColor lightGrayColor];
        _textField2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _textField2.delegate = self;
        _textField2.returnKeyType = UIReturnKeyNext;
        
    }
    return _textField2;
}

-(UITextField *)textField3 {
    if (!_textField3) {
        _textField3 = [[UITextField alloc]init];
        _textField3.backgroundColor = [UIColor whiteColor];
        _textField3.placeholder = @"组";
        _textField3.textColor = [UIColor lightGrayColor];
        _textField2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _textField3.delegate = self;
        _textField3.returnKeyType = UIReturnKeyDone;
    }
    return _textField3;
}

-(UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

#pragma mark -- 删除按钮
-(void)deleteBtnClick {
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self commonInit];
    }
    return self;
}


-(void)commonInit {
    
    [self.contentView addSubview:self.textField1];
    [self.contentView addSubview:self.textField2];
    [self.contentView addSubview:self.textField3];
    
    
    
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marginX = self.frame.size.width/4.0;

//    self.textField1.frame = CGRectMake(0,0,self.frame.size.width/3.0,self.frame.size.height);
    [self.textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.width.mas_equalTo(self.frame.size.width/2.0);
        make.height.mas_equalTo(self.frame.size.height);
    }];
    [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textField1.mas_right).offset(marginX-15);
        make.top.mas_equalTo(self.textField1.mas_top);
        make.width.mas_equalTo(@(marginX/2));
        make.height.mas_equalTo(self.frame.size.height);
    }];
    [self.textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textField2.mas_right).offset(marginX/5);
        make.top.mas_equalTo(self.textField1.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
//        make.width.mas_equalTo(@(marginX/2));
        make.height.mas_equalTo(self.frame.size.height);
    }];
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (indexPath.row > 0) {
//        self.deleteBtn.frame = CGRectMake(5, 10, 30, 30);
//        [self.contentView addSubview:self.deleteBtn];
//        [self.textField1 mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.deleteBtn.mas_right).offset(15);
//        }];
//        [self.contentView updateConstraintsIfNeeded];
        
    }
}


#pragma mark --  textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _textField1) {
        [_textField1 resignFirstResponder];
        [_textField2 becomeFirstResponder];
    }else if (textField == _textField2) {
        [_textField2 resignFirstResponder];
        [_textField3 becomeFirstResponder];
    }else {
        [_textField3 resignFirstResponder];
    }
    
    
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
     NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    NSLog(@"--> %@",toBeString);
    if (textField == _textField1) {
//         _textField1.text = toBeString;
    }else if (textField == _textField2 || textField == _textField3) {
        // textField.text.length+string.length-range.length > 2
        if (toBeString.length > 2) { //如果输入框内容大于2则输入无效
            return NO;
        }
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _textField1) {
        _briefName = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }else if (textField == _textField2) {
        _num = textField.text;
    }else {
        _group = textField.text;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellWith:)]) {
        
        [self.delegate cellWith:_indexPath];//_indexPath是在（- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath方法中传过来的indexPath）
    }
}



//触屏－可回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITextField *textField in self.contentView.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
            [textField resignFirstResponder];
        }
    }
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
