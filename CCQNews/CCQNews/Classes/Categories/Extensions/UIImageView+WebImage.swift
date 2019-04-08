//
//  UIImageView+WebImage.swift
//  test1
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 itcast. All rights reserved.
//

import SDWebImage
extension UIImageView {
    
    /// 隔离 SDWebImage 设置图像函数
    ///
    /// - parameter urlString:        urlString
    /// - parameter placeholderImage: 占位图像
    /// - parameter isRoundHead:         是否将圆头像变成方头像
    func ccq_setImage(urlString: String?, placeholderImage: UIImage?, isRoundHead: Bool = false) {
        if isRoundHead {
            let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: self.bounds.size)
            let maskLayer = CAShapeLayer();
            //设置大小
            maskLayer.frame = self.bounds;
            //设置图形样子
            maskLayer.path = maskPath.cgPath;
            self.layer.mask = maskLayer;
        }
        // 处理 URL
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
            // 设置占位图像
            image = placeholderImage
            
            return
        }
        sd_setImage(with: url, placeholderImage: placeholderImage, options: .retryFailed, completed: nil)
    }
}
