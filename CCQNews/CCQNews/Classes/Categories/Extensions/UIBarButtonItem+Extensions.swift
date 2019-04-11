//
//  UIBarButtonItem+Extensions.swift
//  传智微博
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建 UIBarButtonItem
    ///
    /// - parameter title:    title
    /// - parameter fontSize: fontSize，默认 16 号
    /// - parameter target:   target
    /// - parameter action:   action
    /// - parameter isBack:   是否是返回按钮，如果是加上箭头
    ///
    /// - returns: UIBarButtonItem
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action: Selector, isBack: Bool = false) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage(named: imageName), for: UIControl.State(rawValue: 0))
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        // self.init 实例化 UIBarButtonItem
        self.init(customView: btn)
    }
    convenience init(title: String, fontSize: CGFloat = 16, image: UIImage, target: AnyObject?, action: Selector) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: kCCQAppMainColor)
        let imageName = "navigationbar_back_withtext"
        btn.setImage(image, for: UIControl.State.normal)
        
        
//        let focusBtn = UIButton(type: UIButton.ButtonType.custom)
//        focusBtn.setTitle("发布", for: .normal)
//        focusBtn.setImage(UIImage(named: "icon_released"), for: .normal)
//        //使图片和文字水平居中显示
//        focusBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
//        //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//        focusBtn.titleEdgeInsets = UIEdgeInsets(top: focusBtn.imageView?.frame.size.height ?? 50, left: -(focusBtn.imageView?.frame.size.width ?? 50), bottom: 0.0, right: 0.0)
//        focusBtn.imageEdgeInsets = UIEdgeInsets(top: -(focusBtn.imageView?.frame.size.height ?? 50), left: 0.0, bottom: 0.0, right: -(focusBtn.titleLabel?.frame.size.width ?? 50))
        btn.addTarget(target, action: action, for: .touchUpInside)
        // self.init 实例化 UIBarButtonItem
        self.init(customView: btn)
    }
//    icon_released
}
