//
//  CCQReleasedTextVC.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/10.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit
import IQKeyboardManager
class CCQReleasedTextVC: CCQBaseViewController {
    @IBOutlet weak var textView: IQTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "发文字"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(released(_:)))
        // Do any additional setup after loading the view.
    }
    @objc func released(_ sender: UIBarButtonItem) {
        if CCQTools.isBlankString(string: CCQUser.shared.account) {
            let loginVC = CCQLoginVC(nibName: "CCQLoginVC", bundle: nil)
            navigationController?.pushViewController(loginVC, animated: true)
            return
        }
        if CCQTools.isBlankString(string: textView.text) {
            CCQTools.showTextHudWithText(text: "请输入内容", view: view)
            return
        }
        // 模拟演示加载数据
        CCQTools.showWaitingHudInView(view: view)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            if let strongSelf = self {
                CCQTools.hideWaitingHudInView(view: strongSelf.view)
                CCQTools.showTextHudWithText(text: "发布成功,审核通过后将会在列表上展示.", view: strongSelf.view)
            }
        }

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
