//
//  CCQReleasedImageVC.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/11.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit
import Photos
import IQKeyboardManager

class CCQReleasedImageVC: CCQBaseViewController {
    @IBOutlet weak var textView: IQTextView!
    @IBOutlet weak var imageBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "发图文"
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

    @IBAction func addImage(_ sender: UIButton) {
        CCQSystemAlertView.showSystemActionSheet(withTitle: nil, message: nil, contentArray: ["取消", "拍照", "相册"], controller: self) {[weak self](seleteIndex: Int) in
            if 1 == seleteIndex {
                self?.openImagePickerControllerWithType(type: UIImagePickerController.SourceType.camera)
            } else if 2 == seleteIndex {
                self?.openImagePickerControllerWithType(type: UIImagePickerController.SourceType.photoLibrary)
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
//MARK: - 相册相关
extension CCQReleasedImageVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openImagePickerControllerWithType(type: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(type) && isCanUsePhotos() {
            let imgPicker = UIImagePickerController()
            imgPicker.sourceType = type;
            imgPicker.delegate = self
            self.present(imgPicker, animated: true, completion: nil)
        } else {
            CCQTools.showTextHudWithText(text: "请在设置内开启相机/相册权限再试", view: view)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]
        imageBtn.setImage(image as? UIImage, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func isCanUsePhotos() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .restricted || status == .denied {
            return false
        }
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .restricted || status == .denied {
            return false
        }
        return true
    }
}
