//
//  CCQVideosListVC.swift
//  CCQNews
//
//  Created by test on 2019/4/5.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit
import ZFPlayer

/// 视频cell
private let videosListCellIDF = "videosListCellIDF"
class CCQVideosListVC: CCQBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var pageIndex = 2
    lazy var NewsModelList = [CCQNewsListModel]()
    var player: ZFPlayerController?
    lazy var controlView = ZFPlayerControlView()
    lazy var urls = [URL]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    ///重写父类的setupUI方法
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "视频段子"
        setupTableView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.stopCurrentPlayingCell()
    }
}
// MARK: - 设置界面
extension CCQVideosListVC {
    private func setupTableView() {
        ///添加下拉刷新
        CCQTools.addDropDownToRefreshAtTableView(tableView: tableView) {[weak self] in
            if let strongSelf = self {
                strongSelf.loadData(pageIndex: 2)
            }
        }
        ///添加上拉加载
        CCQTools.addPullToRefreshAtTableView(tableView: tableView) {[weak self] in
            if let strongSelf = self {
                strongSelf.loadData(pageIndex: strongSelf.pageIndex)
            }
        }
        tableView.mj_footer.isHidden = true;
        tableView.estimatedRowHeight = 270
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "CCQHomeListCell", bundle: nil), forCellReuseIdentifier: videosListCellIDF)
        setupZFPlayer()
        CCQTools.beginDropDownRefreshingAtTableView(tableView: tableView)
    }
    func setupZFPlayer() {
        let playerManager = ZFAVPlayerManager()
        /// player的tag值必须在cell里设置
        player = ZFPlayerController(scrollView: tableView, playerManager: playerManager, containerViewTag: 100)
        player?.controlView = controlView;
        player?.shouldAutoPlay = false;
        /// 1.0是完全消失的时候
        player?.playerDisapperaPercent = 1.0;
        player?.orientationWillChange = {[weak self](player: ZFPlayerController, isFullScreen: Bool) in
            if let strongSelf = self {
                strongSelf.setNeedsStatusBarAppearanceUpdate();
                UIViewController.attemptRotationToDeviceOrientation();
                strongSelf.tableView.scrollsToTop = !isFullScreen;
            }
        }
        player?.playerDidToEnd = {[weak self](_) in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.player?.playingIndexPath?.row ?? 0 < strongSelf.urls.count - 1 && strongSelf.player?.isFullScreen ?? false {
                let indexPath = IndexPath(row: strongSelf.player?.playingIndexPath?.row ?? 0 + 1, section: 0)
                strongSelf.playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: true)
            } else if strongSelf.player?.isFullScreen ?? false {
                strongSelf.player?.stopCurrentPlayingCell()
            }
        }
    }
    
}
// MARK: - ZFPlayer method
extension CCQVideosListVC {
    func playTheVideoAtIndexPath(indexPath: IndexPath, scrollToTop: Bool) {
        player?.playTheIndexPath(indexPath, scrollToTop: scrollToTop)
        let model = NewsModelList[indexPath.row]
        controlView.showTitle(model.text ?? "标题", coverURLString: model.thumbnail ?? "", fullScreenMode: .automatic)
    }
    override var shouldAutorotate : Bool {
        return false
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if player?.isFullScreen ?? true && player?.orientationObserver.fullScreenMode == .landscape {
            return .landscape;
        }
        return .portrait;
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent;
    }
    override var prefersStatusBarHidden : Bool {
        return player?.isStatusBarHidden ?? false;
    }
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .slide;
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidEndDecelerating()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.zf_scrollViewDidEndDraggingWillDecelerate(decelerate)
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScrollToTop()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScroll()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewWillBeginDragging()
    }

}

// MARK: - 请求网络数据
extension CCQVideosListVC {
    private func loadData(pageIndex: Int) {
        self.pageIndex = pageIndex;
        let parameters = ["type" : "5", "page" : "\(pageIndex)"]
        CCQTools.showWaitingHudInView(view: view)
        _ = CCQHttpRequestManager.shared.request(urlString: kNEWSAPI, parameters: parameters as [String : AnyObject]) { (json, isSuccess) in
            CCQTools.hideWaitingHudInView(view: self.view)
            CCQTools.endDropDownRefreshingAtTableView(tableView: self.tableView)
            CCQTools.endPullToRefreshAtTableView(tableView: self.tableView);
            if isSuccess {
                guard let jsonData = json as? [String: AnyObject] else {
                    CCQTools.showTextHudWithText(text: "获取数据失败", view: self.view)
                    return
                }
                let code = jsonData["code"] as? Int
                if code == 200 {
                    if self.pageIndex == 2 {
                        self.NewsModelList.removeAll()
                        self.urls.removeAll()
                    }
                    let list = jsonData["data"] as? [[String: AnyObject]]
                    for dict in list ?? [] {
                        let newsListModel = CCQNewsListModel.ccq_model(with: dict)
                        if let notEmptyNewsListModel = newsListModel, let URLString =  notEmptyNewsListModel.video?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let notEmptyUrl = URL(string: URLString) {
                            self.NewsModelList.append(notEmptyNewsListModel)
                            self.urls.append(notEmptyUrl)
                        }
                    }
                    if (list?.count ?? [].count < 20) {
                        CCQTools.endRefreshingWithNoMoreDataAtTableView(tableView: self.tableView)
                    } else {
                        self.pageIndex += 1;
                    }
                    
                    self.tableView.mj_footer.isHidden = false
                    self.player?.assetURLs = self.urls;
                    self.tableView.reloadData()
                } else {
                    CCQTools.showTextHudWithText(text: "获取数据失败,请下拉刷新重试", view: self.view)
                }
            } else {
                CCQTools.showTextHudWithText(text: "网络错误,请检查网络后下拉刷新重试.", view: self.view)
            }
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension CCQVideosListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.NewsModelList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: videosListCellIDF, for: indexPath) as! CCQHomeListCell
        cell.newsListModel = self.NewsModelList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playTheVideoAtIndexPath(indexPath: indexPath, scrollToTop: false)
    }
}
