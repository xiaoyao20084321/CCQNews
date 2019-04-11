//
//  CCQReleasedVideoVC.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/11.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit
import Photos
import IQKeyboardManager
class CCQReleasedVideoVC: CCQBaseViewController {
    @IBOutlet weak var textView: IQTextView!
    @IBOutlet weak var imageBtn: UIButton!
    deinit {
        print("释放了")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "发视频"
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
        openImagePickerControllerWithType(type: UIImagePickerController.SourceType.savedPhotosAlbum)
    }
}
//MARK: - 相册相关
extension CCQReleasedVideoVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openImagePickerControllerWithType(type: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(type) && isCanUsePhotos() {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.videoQuality = UIImagePickerController.QualityType.typeMedium;
            imgPicker.allowsEditing = false;
            imgPicker.videoMaximumDuration = 1.0;
            imgPicker.mediaTypes = ["public.movie"]
            imgPicker.sourceType = type;
            self.present(imgPicker, animated: true, completion: nil)
        } else {
            CCQTools.showTextHudWithText(text: "请在设置内开启相机/相册权限再试", view: view)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] {
            if mediaType as? String == "public.movie" {
                let url = info[UIImagePickerController.InfoKey.mediaURL]
                if let newUrl:URL = url as? URL {
                    let image = firstFrameWithVideoURL(path: newUrl)
                    imageBtn.setImage(image, for: .normal)
                }
            }
        }
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
    ///获取视频的第一帧
    func firstFrameWithVideoURL(path: URL) -> UIImage {
        let avAsset = AVAsset(url: path)
        //生成视频截图
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0,preferredTimescale: 600)
        var actualTime:CMTime = CMTimeMake(value: 0,timescale: 0)
        let imageRef:CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
        let frameImg = UIImage(cgImage: imageRef)
        return frameImg
    }
}
