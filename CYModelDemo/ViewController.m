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
    NSDictionary * dic = @{@"name":@"gaochenyang",@"school":@"university",@"sex":@"man"};
    PersonModel * model = (PersonModel *)[PersonModel cy_modelWithDict:dic];
    
}
@end
