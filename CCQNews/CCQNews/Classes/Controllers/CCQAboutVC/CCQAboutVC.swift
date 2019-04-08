//
//  CCQAboutVC.swift
//  CCQNews
//
//  Created by test on 2019/4/8.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit

class CCQAboutVC: CCQBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "关于软件"
    }

    @IBAction func enterPrivacyPolicy(_ sender: UIButton) {
        let newsDetailVC = CCQNewsDetailVC(nibName: "CCQNewsDetailVC", bundle: nil)
        let filePath = Bundle.main.url(forResource: "yinsizhengce", withExtension: "html")
        let urlString = filePath?.absoluteString
        newsDetailVC.urlStrig = urlString
        navigationController?.pushViewController(newsDetailVC, animated: true)
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
