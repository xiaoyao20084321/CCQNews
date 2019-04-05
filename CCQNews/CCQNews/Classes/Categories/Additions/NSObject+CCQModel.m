//
//  NSObject+CCQModel.m
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/2.
//  Copyright © 2019 常超群. All rights reserved.
//

#import "NSObject+CCQModel.h"
#import "YYModel.h"
@implementation NSObject (CCQModel)
/////字典转对象
+ (nullable instancetype)ccq_modelWithDictionary:(NSDictionary *)dictionary {
    return [self yy_modelWithDictionary:dictionary];
}
@end
