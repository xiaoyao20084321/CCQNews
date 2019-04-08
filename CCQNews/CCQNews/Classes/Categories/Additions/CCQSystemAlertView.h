//
//  CCQSystemAlertView.h
//  SinYiHomeApp
//
//  Created by test on 16/6/12.
//  Copyright © 2016年 test1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CCQSystemAlertView : NSObject

/**
 *  多个按钮的alertView     数组里第一个为取消按钮
 *
 *  @param title        title
 *  @param message      message
 *  @param contentArray 内容数组
 *  @param controller   VC
 *  @param deleteBlock 点击删除回调
 */
+ (void)showSystemalertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                          contentArray:(NSArray *)contentArray
                            controller:(UIViewController *)controller
                          confirmBlock:(void (^)(NSInteger selectedIndex))confirmBlock;


/**
 *  多个按钮的ActionSheet     数组里第一个为取消按钮
 *
 *  @param title        title
 *  @param message      message
 *  @param contentArray 内容数组(数组里第一个为取消按钮)
 *  @param controller   VC
 *  @param deleteBlock 点击删除回调
 */
+ (void)showSystemActionSheetWithTitle:(NSString *)title
                               message:(NSString *)message
                          contentArray:(NSArray *)contentArray
                            controller:(UIViewController *)controller
                          confirmBlock:(void (^)(NSInteger selectedIndex))confirmBlock;
@end
