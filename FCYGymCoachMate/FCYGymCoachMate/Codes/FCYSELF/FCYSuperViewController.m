//
//  FCYSuperViewController.m
//  FCYPushAndPop01
//
//  Created by bwfstu on 16/2/29.
//  Copyright © 2016年 ancaifcy. All rights reserved.
//

#import "FCYSuperViewController.h"

@interface FCYSuperViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation FCYSuperViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


//弹出提示框
-(void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];

//    修改成功提示条
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((FCYSIZE.width - LabelSize.width - 20)/2, FCYSIZE.width - 80, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:1.5 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

//创建手势
-(void)createOneGRWithType:(FCYTypeGR)typeGR andAddView:(UIView *)view {
    if (typeGR == Tap) {
        UITapGestureRecognizer *tapGR1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGRClick:)];
        tapGR1.numberOfTapsRequired = 1; //单击
        //        UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AllOfGRClick:)];
        //        tapGR2.numberOfTapsRequired = 2;  //双击
        //        [view addGestureRecognizer:tapGR2];
        [view addGestureRecognizer:tapGR1];
        //  先响应双击（若有）
        //        [tapGR1 requireGestureRecognizerToFail:tapGR2];
        
    }else if (typeGR == LongPress) {
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongGRClick:)];
        longPressGR.numberOfTouchesRequired = 1;  //手指个数
        longPressGR.minimumPressDuration = 2;   //持续时间
        [view addGestureRecognizer:longPressGR];
    }else if (typeGR == Swipe) {
        UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeGRClick:)];
        swipeGR.direction = UISwipeGestureRecognizerDirectionLeft; //左滑
        swipeGR.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:swipeGR];
    }else if (typeGR == Pan) {
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGRClick:)];
        //用户体验，可以添加到self.view上
        [self.view addGestureRecognizer:panGR];
    }else if (typeGR == Rotation) {
        UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(RotationGRClick:)];
        [view addGestureRecognizer:rotationGR];
    }else if (typeGR == Pinch) {
        UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(PinchGRClick:)];
        [view addGestureRecognizer:pinchGR];
    }
}
-(void)TapGRClick:(UITapGestureRecognizer *)sender {
    
}
-(void)LongGRClick:(UILongPressGestureRecognizer *)sender {
    
}
-(void)SwipeGRClick:(UISwipeGestureRecognizer *)sender {
    
}
-(void)PanGRClick:(UIPanGestureRecognizer *)sender {
    
}
-(void)RotationGRClick:(UIRotationGestureRecognizer *)sender {
    static float rotation;
    sender.view.transform = CGAffineTransformMakeRotation(sender.rotation+rotation);
    if (sender.state == UIGestureRecognizerStateEnded) {
        rotation += sender.rotation;
    }
    
}
-(void)PinchGRClick:(UIPinchGestureRecognizer *)sender {
    static float scale = 1;
    sender.view.transform = CGAffineTransformMakeScale(scale*sender.scale, scale*sender.scale);
    if (sender.state == UIGestureRecognizerStateEnded) {
        scale *= sender.scale;
    }
    
}



#pragma mark -- 创建导航栏左右按钮
// 左右都是 button 来创建 (单个)
-(void)createNavigationItemsWithTitle:(NSString *)title andWithImage:(UIImage *)image andWithType:(BOOL)type andWithTag:(NSString *)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 30);
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        if (type) {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)]; // 图片靠左
        }else {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];  // 图片靠右
        }
        
    }
    [button addTarget:self action:@selector(onBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = [tag intValue];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    if (type) {
        self.navigationItem.leftBarButtonItem = item;
    }else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

-(void)onBarButtonClick:(UIButton *)sender {
    
}




#pragma mark -- alert
//-(void)alertWithMessage:(NSString *)msg {
//    if(IS_iOS8){
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"标题" message:msg preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//        [alertC addAction:cancelAction];
//        [alertC addAction:okAction];
//        [self presentViewController:alertC animated:YES completion:nil];
//    }else {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        [alert show];
//    }
//}


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
