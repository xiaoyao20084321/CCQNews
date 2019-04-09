//
//  CCQVideoListCell.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/9.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit

class CCQVideoListCell: UITableViewCell {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    var playBtn: UIButton!
    
//    var playBtn: UIButton?

    var indexPath:IndexPath?
    var playVideo: ((_ indexPath: IndexPath) -> ())?
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
        playBtn = UIButton(type: .custom)
        playBtn.setImage(UIImage(named: "icon_video_play"), for: .normal)
        playBtn.addTarget(self, action: #selector(playVideo(_:)), for: .touchUpInside)
        contentImageView.addSubview(playBtn)
        // Initialization code
    }
    override func layoutSubviews() {
        playBtn.frame = CGRect(x: (contentImageView.frame.width / 2) - (playBtn.frame.width / 2), y: contentImageView.frame.height / 2 - (playBtn.frame.height / 2), width: 44, height: 44)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func playVideo(_ sender: UIButton) {
        guard let newIndexPath = indexPath else {
            return
        }
        playVideo?(newIndexPath)
    }
}
