//
//  NSObject+DebugDescription.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/30.
//

#import "NSObject+DebugDescription.h"

@implementation NSObject (DebugDescription)
/// debugDescription方法只会在调试po的时候调用，而在代码中打印不会调用
- (NSString *)debugDescription {
    //判断是否时NSArray 或者NSDictionary NSNumber 如果是的话直接返回 debugDescription
    if ([self isKindOfClass:NSArray.class] ||
        [self isKindOfClass:NSDictionary.class] ||
        [self isKindOfClass:NSString.class] ||
        [self isKindOfClass:NSNumber.class]) {
        return [self debugDescription];
    }
    //声明一个字典
    NSMutableDictionary *dictionary = NSMutableDictionary.dictionary;
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    //循环并用KVC得到每个属性的值
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";//默认值为nil字符串
        [dictionary setObject:value forKey:name];//装载到字典里
    }
    //释放
    free(properties);
    //return
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];
}

@end
