//
//  CCQLoginVC.swift
//  CCQNews
//
//  Created by test on 2019/4/7.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit

class CCQLoginVC: CCQBaseViewController {
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loginSuccessful: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "请登录"
        // Do any additional setup after loading the view.
    }
    deinit {
        print("释放了")
    }

    @IBAction func goToRegister(_ sender: UIButton) {
        let registerVC = CCQRegisterVC(nibName: "CCQRegisterVC", bundle: nil)
        
        registerVC.registerSuccessful = { [weak self] in
            if let strongSelf = self {
                strongSelf.loginSuccessful?()
            }
        }
        navigationController?.pushViewController(registerVC, animated: true)
    }
    @IBAction func login(_ sender: UIButton) {
        if CCQTools.isBlankString(string: accountTextField.text) {
            CCQTools.showTextHudWithText(text: "请输入账号", view: view)
            return
        }
        if CCQTools.isBlankString(string: passwordTextField.text) {
            CCQTools.showTextHudWithText(text: "请输入密码", view: view)
            return
        }
        // 模拟演示加载数据
        CCQTools.showWaitingHudInView(view: view)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            if let strongSelf = self {
                CCQTools.hideWaitingHudInView(view: strongSelf.view)
                CCQUser.shared.updataUser(dict: ["account" : strongSelf.accountTextField?.text as AnyObject, "password" : strongSelf.passwordTextField?.text as AnyObject])
                ///登录成功
                strongSelf.navigationController?.popViewController(animated: false)
                strongSelf.loginSuccessful?()
            }
        }
    }
    
}
// MARK: - UITextFieldDelegate
extension CCQLoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

