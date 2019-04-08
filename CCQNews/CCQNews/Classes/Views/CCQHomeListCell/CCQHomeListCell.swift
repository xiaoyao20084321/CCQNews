//
//  CCQHomeListCell.swift
//  CCQNews
//
//  Created by test on 2019/4/4.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit
class CCQHomeListCell: UITableViewCell {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    var newsListModel: CCQNewsListModel? {
        //替代OC中重写setter方法，didSet没有代码提示
        //区别：不用考虑 _成员变量 = 值！
        //OC中如果是copy属性，应该 _成员变量 = 值 copy
        didSet {
            //此时属性已经有值，可以直接使用设置UI内容
            headerImageView.ccq_setImage(urlString: newsListModel?.header ?? "", placeholderImage: UIImage(named: "icon_error"), isRoundHead: true)
            nickNameLabel.text = newsListModel?.username
            contentLabel.text = newsListModel?.text
            contentImageView.ccq_setImage(urlString: newsListModel?.thumbnail ?? "", placeholderImage: UIImage(named: "icon_error"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
