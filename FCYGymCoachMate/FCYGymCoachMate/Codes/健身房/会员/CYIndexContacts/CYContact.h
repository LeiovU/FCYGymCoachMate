//
//  CYContact.h
//  CYContacts
//
//  Created by Fangcy on 2017/4/18.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CYContact : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)UIImage *icon;
// 搜索联系人的方法 (拼音/拼音首字母缩写/汉字)
+(NSArray <CYContact *> *)searchText:(NSString *)searchText inDataArray:(NSArray <CYContact *> *)dataArray;

@end
