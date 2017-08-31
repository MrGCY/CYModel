//
//  ViewController.m
//  CYModelDemo
//
//  Created by Mr.GCY on 2017/8/30.
//  Copyright © 2017年 Mr.GCY. All rights reserved.
//

#import "ViewController.h"
#import "PersonModel.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * dic = @{@"name":@"gaochenyang",@"school":@"university",@"sex":@"man",@"isNice":@(YES),@"age":@(10),@"height" : @(1.86),@"dog":@{@"name":@"dog1",@"sex":@"1"},@"dogs":@[@{@"name":@"dog1",@"sex":@"1"},@{@"name":@"dog1",@"sex":@"1"},@{@"name":@"dog1",@"sex":@"1"},@{@"name":@"dog1",@"sex":@"1"}]};
    NSArray * arr = @[dic,dic,dic,dic];
    PersonModel * model = (PersonModel *)[PersonModel cy_modelWithDict:dic];
    NSArray * models = [PersonModel cy_arrayOfModelsFromDictionaries:arr];
    
}
@end
