//
//  CCQFeedbackVC.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/8.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit

class CCQFeedbackVC: CCQBaseViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textFieldSuperView: UIView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSuperView.layer.borderWidth = 2
        textFieldSuperView.layer.borderColor = UIColor.ccq_color(withHex: "#F3F3F3")?.cgColor
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.ccq_color(withHex: "#F3F3F3")?.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4);
        navigationItem.title = "意见反馈"
    }
    @IBAction func confirm(_ sender: UIButton) {
        if CCQTools.isBlankString(string: textField.text) {
            CCQTools.showTextHudWithText(text: "请输入反馈标题", view: view)
            return
        }
        if CCQTools.isBlankString(string: textView.text) {
            CCQTools.showTextHudWithText(text: "请输入反馈内容", view: view)
            return
        }
        // 模拟演示加载数据
        CCQTools.showWaitingHudInView(view: view)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            if let strongSelf = self {
                CCQTools.hideWaitingHudInView(view: strongSelf.view)
                CCQTools.showTextHudWithText(text: "反馈成功,谢谢您的配合!", view: strongSelf.view)
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
// MARK: - UITextFieldDelegate
extension CCQFeedbackVC: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension CALayer {
    var borderColorFromUIColor: UIColor {
        get {
            return UIColor(cgColor: self.borderColor!)
        } set {
            self.borderColor = newValue.cgColor
        }
    }
}
