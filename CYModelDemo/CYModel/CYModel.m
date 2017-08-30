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
        //attributes:T@\"NSString\",&,N,V_school
        NSScanner * scanner = [[NSScanner alloc] initWithString:attributes];
        [scanner scanString:@"T" intoString:NULL];
        NSString * propertyType;
        if ([scanner scanString:@"@\"" intoString:&propertyType]) {
            [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&propertyType];
        }
        //获取字典中该属性键的值
        id value = [dict objectForKey:propertyName];
        if (value) {
            [objc setValue:value forKey:propertyName];
//            objc_setAssociatedObject([self class], &propertyName, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        NSLog(@"attributes:%@ ------propertyName:%@",propertyType,propertyName);
        
    }
    return objc;
}
@end
