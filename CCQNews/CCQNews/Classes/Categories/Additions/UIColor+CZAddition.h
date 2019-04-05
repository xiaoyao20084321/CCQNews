//
//  UIColor+CZAddition.h
//
//  Created by 刘凡 on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CZAddition)

/**
 使用使用 16 进制数字创建颜色，例如 0xFF0000 创建红色

 @param hex 16 进制无符号
 @return 颜色
 */
+ (UIColor *)ccq_colorWithHex:(NSString *)hex;

/**
 使用使用 16 进制数字创建颜色，例如 0xFF0000 创建红色

 @param hex hex 16 进制无符号
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)ccq_colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;
@end
