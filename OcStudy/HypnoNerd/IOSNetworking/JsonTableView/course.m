//
//  course.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/26.
//

#import "course.h"
#import <objc/runtime.h>

@implementation course

- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self = [self init]) {
        //(1)获取类的属性及属性对应的类型
        self.count = 0;
        NSMutableArray * keys = [NSMutableArray array];
        
        unsigned int outCount;
        objc_property_t * properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            objc_property_t property = properties[i];
            //通过property_getName函数获得属性的名字
            NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
        }
        //立即释放properties指向的内存
        free(properties);

        //(2)根据类型给属性赋值
        for (NSString * key in keys) {
            if ([dict valueForKey:key] == nil) continue;
            [self setValue:[dict valueForKey:key] forKey:key];
            self.count += 1;
        }
    }
    return self;
}

@end
