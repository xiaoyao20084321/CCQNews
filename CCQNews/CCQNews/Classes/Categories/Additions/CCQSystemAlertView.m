//
//  CCQSystemAlertView.m
//  SinYiHomeApp
//
//  Created by test on 16/6/12.
//  Copyright © 2016年 test1. All rights reserved.
//

#import "CCQSystemAlertView.h"

@implementation CCQSystemAlertView
+ (void)showSystemalertViewWithTitle:(NSString *)title
                             message:(NSString *)message
                        contentArray:(NSArray *)contentArray
                          controller:(UIViewController *)controller
                        confirmBlock:(void (^)(NSInteger selectedIndex))confirmBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
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
@end
