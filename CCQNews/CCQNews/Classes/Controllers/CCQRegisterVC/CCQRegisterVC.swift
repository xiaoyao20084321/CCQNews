//
//  CCQRegisterVC.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/7.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit

class CCQRegisterVC: CCQBaseViewController {
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var firstPassWord: UITextField!
    
    @IBOutlet weak var secondPassword: UITextField!
    
    var registerSuccessful: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "请注册"
        // Do any additional setup after loading the view.
    }
    deinit {
        print("释放了")
    }

    @IBAction func register(_ sender: UIButton) {
        if CCQTools.isBlankString(string: accountTextField.text) {
            CCQTools.showTextHudWithText(text: "请输入账号", view: view)
            return
        }
        if CCQTools.isBlankString(string: firstPassWord.text) {
            CCQTools.showTextHudWithText(text: "请输入密码", view: view)
            return
        }
        if CCQTools.isBlankString(string: secondPassword.text) {
            CCQTools.showTextHudWithText(text: "请输入密码", view: view)
            return
        }
        if firstPassWord.text != secondPassword.text {
            CCQTools.showTextHudWithText(text: "两次密码输入不一致", view: view)
            return
        }
        CCQTools.showWaitingHudInView(view: view)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            if let strongSelf = self {
                CCQTools.hideWaitingHudInView(view: strongSelf.view)
                CCQUser.shared.updataUser(dict: ["account" : strongSelf.accountTextField?.text as AnyObject, "password" : strongSelf.firstPassWord?.text as AnyObject])
                ///登录成功
                strongSelf.navigationController?.popToRootViewController(animated: false)
                strongSelf.registerSuccessful?()
            }
            
        }
    }
}
// MARK: - UITextFieldDelegate
extension CCQRegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
