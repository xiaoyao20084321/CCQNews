//
//  CCQPersonalCenterHeaderView.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/6.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit

class CCQPersonalCenterHeaderView: UIView {

    @IBOutlet weak var headerContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerContentViewTop: NSLayoutConstraint!

    @IBOutlet weak var headerContentViewLeft: NSLayoutConstraint!

    @IBOutlet weak var headerContentViewRight: NSLayoutConstraint!
    var headerHeight: CGFloat = 250
    
    
    @IBOutlet weak var userHeaderImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func ccq_scrollDidScroll(scrollView: UIScrollView) {
        let offset_Y = scrollView.contentOffset.y
        if offset_Y < 0 {
            headerContentViewTop.constant = offset_Y;
            headerContentViewLeft.constant = offset_Y / 2;
            headerContentViewRight.constant = offset_Y / 2;
            headerContentViewHeight.constant = self.headerHeight+(-offset_Y);
        }
        layoutIfNeeded()
    }
}
