//
//  CYModel.m
//  CYModelDemo
//
//  Created by Mr.GCY on 2017/8/30.
//  Copyright © 2017年 Mr.GCY. All rights reserved.
//

#import "CYModel.h"
#import <objc/message.h>
@implementation CYModel
//传入字典转化对应的模型
+(instancetype)cy_modelWithDict:(NSDictionary *)dict{
    //创建对应的对象
    id objc = [[self alloc] init];
    //获取所有的属性
    unsigned int propertyCount;
    objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
    //遍历所有属性
    for (int i = 0; i < propertyCount; i++) {
        //获取单个属性
        objc_property_t property = properties[i];
        //获取属性名字
        NSString * propertyName = [NSString stringWithUTF8String:property_getName(property)];
        //获取属性类型
        NSString * attributes =[NSString stringWithUTF8String:property_getAttributes(property)];
        NSLog(@"attributes:-----------%@",attributes);
        //attributes:T@\"NSString\",&,N,V_school   TB,N,V_isNice
        NSScanner * scanner = [[NSScanner alloc] initWithString:attributes];
        [scanner scanString:@"T" intoString:NULL];
        NSString * propertyType;
        if ([scanner scanString:@"@\"" intoString:&propertyType]) {
            [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&propertyType];
        }else{
            [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","] intoString:&propertyType];
        }
        //获取字典中该属性键的值
        id value = [dict objectForKey:propertyName];
        
        // 二级转换:如果字典中还有字典，也需要把对应的字典转换成模型
        // 判断下value是否是字典,并且是自定义对象才需要转换 自定义对象也需要继承CYModel
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType hasPrefix:@"NS"]) {
            // 根据字符串类名生成类对象
            Class modelClass = objc_getClass([propertyName UTF8String]);
            if (modelClass) {
                value = [modelClass cy_modelWithDict:value];
            }
        }else if([value isKindOfClass:[NSArray class]]){
            // 判断值是否是数组
            // 三级转换：NSArray中也是字典，把数组中的字典转换成模型 自定义对象也需要继承CYModel.
            value = [objc cy_arrayWithArray:value andKey:propertyName];
        }
        if (value) {
            [objc setValue:value forKey:propertyName];
        }
        NSLog(@"attributes:%@ ------propertyName:%@",propertyType,propertyName);
    }
    return objc;
}
//传入数组数据   传入对应数组的key
-(NSMutableArray *)cy_arrayWithArray:(NSArray *)arr andKey:(NSString *)key{
    NSMutableArray * endArray = [NSMutableArray arrayWithCapacity:0];
    //相同类中的协议 调用   获取数组元素需要转换的模型类
    if ([self respondsToSelector:@selector(cy_arrayContainModelClass)]) {
        // 转换成id类型，就能调用任何对象的方法
        id idSelf = self;
        NSDictionary * arrayDic = [idSelf cy_arrayContainModelClass];
        if (arrayDic) {
            NSString * classStr = [arrayDic objectForKey:key];
            Class modelClass = objc_getClass([classStr UTF8String]);
            for (NSDictionary * subDic in arr) {
                id model = [modelClass cy_modelWithDict:subDic];
                if (model) {
                    [endArray addObject:model];
                }
            }
        }
    }else{
        //没有要求转换的类型
        [endArray addObjectsFromArray:arr];
    }
    return endArray;
}
//传入字典数组 转化对应的模型数组
+ (NSMutableArray *)cy_arrayOfModelsFromDictionaries:(NSArray *)array{
    NSMutableArray * endArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dict in array) {
        id model = [[self class] cy_modelWithDict:dict];
        if (model) {
            [endArray addObject:model];
        }
    }
    return endArray;
}
@end
