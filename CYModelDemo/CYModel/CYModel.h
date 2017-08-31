//
//  CYModel.h
//  CYModelDemo
//
//  Created by Mr.GCY on 2017/8/30.
//  Copyright © 2017年 Mr.GCY. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ModelDelegate <NSObject>

@optional
//【提供一个协议，只要遵守这个协议的类，都能把数组中的字典转模型】
//【用在三级数组转换】
- (NSDictionary *)cy_arrayContainModelClass;
@end
@interface CYModel : NSObject<ModelDelegate>
//传入字典转化对应的模型
+(instancetype)cy_modelWithDict:(NSDictionary *)dict;
//传入字典数组 转化对应的模型数组
+ (NSMutableArray *)cy_arrayOfModelsFromDictionaries:(NSArray *)array;
@end
