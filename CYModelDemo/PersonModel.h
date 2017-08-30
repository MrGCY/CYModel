//
//  PersonModel.h
//  CYModelDemo
//
//  Created by Mr.GCY on 2017/8/30.
//  Copyright © 2017年 Mr.GCY. All rights reserved.
//

#import "CYModel.h"

@interface PersonModel : CYModel
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * school;
@property(strong,nonatomic)NSString * sex;
@property(assign,nonatomic)BOOL isNice;
@property(assign,nonatomic)NSInteger age;
@property(assign,nonatomic)float height;
//@property(strong,nonatomic)NSArray * score;
@end
