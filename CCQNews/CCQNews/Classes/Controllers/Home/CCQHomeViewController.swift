//
//  CCQHomeViewController.swift
//  ChaoQunWeiBoDemo
//
//  Created by 信义房屋网络事业部 on 2019/3/14.
//  Copyright © 2019年 常超群. All rights reserved.
//

import UIKit

class CCQHomeViewController: CCQBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        let newButton:UIButton = UIButton(frame: CGRect(x: 0, y: 100, width: 50, height: 50))
        newButton.backgroundColor = UIColor.blue
        newButton.setTitle("点我", for: .normal)
        newButton.addTarget(self, action: #selector(newButtonAction), for: .touchUpInside)
        view.addSubview(newButton)
    }
    @objc func newButtonAction() {
        let home = CCQHomeViewController()
        navigationController?.pushViewController(home, animated: true)
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
