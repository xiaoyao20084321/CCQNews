//
//  CCQSystemAlertView.m
//  SinYiHomeApp
//
//  Created by 信义房屋网络事业部 on 16/6/12.
//  Copyright © 2016年 常超群. All rights reserved.
//

#import "CCQSystemAlertView.h"

@implementation CCQSystemAlertView
+ (void)showSystemalertViewWithTitle:(NSString *)title
                             message:(NSString *)message
                        contentArray:(NSArray *)contentArray
                          controller:(UIViewController *)controller
                        confirmBlock:(void (^)(NSInteger selectedIndex))confirmBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    ///设置message的Label居左展示
    [CCQSystemAlertView enumrateSubviewsInView:alertController.view message:message];
    for (NSInteger i = 0; i < contentArray.count; i++) {
        if (0 == i) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:contentArray[i] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (confirmBlock) {
                    confirmBlock(i);
                }
            }];
            [alertController addAction:cancelAction];
        } else {
            UIAlertAction *action = [UIAlertAction actionWithTitle:contentArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (confirmBlock) {
                    confirmBlock(i);
                }
            }];
            [alertController addAction:action];
        }
    }
    
    [controller presentViewController:alertController animated:YES completion:nil];
}
+ (void)showSystemActionSheetWithTitle:(NSString *)title
                               message:(NSString *)message
                          contentArray:(NSArray *)contentArray
                            controller:(UIViewController *)controller
                          confirmBlock:(void (^)(NSInteger selectedIndex))confirmBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i = 0; i < contentArray.count; i++) {
        if (0 == i) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:contentArray[i] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:cancelAction];
        } else {
            UIAlertAction *action = [UIAlertAction actionWithTitle:contentArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (confirmBlock) {
                    confirmBlock(i);
                }
            }];
            [alertController addAction:action];
        }
    }
    
    [controller presentViewController:alertController animated:YES completion:nil];
}
+ (void)enumrateSubviewsInView:(UIView *)view message:(NSString *)message {
    NSArray *subViews = view.subviews;
    if (subViews.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < subViews.count; i++) {
        UIView *subView = subViews[i];
        [CCQSystemAlertView enumrateSubviewsInView:subView message:message];
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            if ([label.text isEqualToString:message]) {
                label.textAlignment = NSTextAlignmentLeft;
            }
        }
    }
}
@end
