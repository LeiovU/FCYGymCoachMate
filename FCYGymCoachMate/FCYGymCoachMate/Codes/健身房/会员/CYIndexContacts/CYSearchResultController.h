//
//  CYSearchResultController.h
//  CYContacts
//
//  Created by Fangcy on 2017/4/18.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYContact;

@interface CYSearchResultController : UIViewController

// 设置数据, 设置内部会自动刷新tableView
@property (nonatomic,strong)NSArray <CYContact *> *data;

@end
