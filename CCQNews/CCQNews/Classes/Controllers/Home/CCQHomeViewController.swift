//
//  CCQHomeViewController.swift
//  ChaoQunWeiBoDemo
//
//  Created by test on 2019/3/14.
//  Copyright © 2019年 test1. All rights reserved.
//

import UIKit
import AFNetworking
/// 新闻cell
private let imagesCellIDF = "imagesCellIDF"
class CCQHomeViewController: CCQBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var pageIndex = 2
    lazy var NewsModelList = [CCQNewsListModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    ///重写父类的setupUI方法
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "图文段子"
        setupTableView()
    }
}
// MARK: - 设置界面
extension CCQHomeViewController {
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
        tableView.register(UINib(nibName: "CCQHomeListCell", bundle: nil), forCellReuseIdentifier: imagesCellIDF)
        CCQTools.beginDropDownRefreshingAtTableView(tableView: tableView)
    }
}
// MARK: - 请求网络数据
extension CCQHomeViewController {
    private func loadData(pageIndex: Int) {
        self.pageIndex = pageIndex;
        let parameters = ["type" : "3", "page" : "\(pageIndex)"]
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
                    }
                    let list = jsonData["data"] as? [[String: AnyObject]]
                    for dict in list ?? [] {
                        let newsListModel = CCQNewsListModel.ccq_model(with: dict)
                        if let newsListModel = newsListModel {
                            self.NewsModelList.append(newsListModel)
                        }
                    }
                    if (list?.count ?? [].count < 20) {
                        CCQTools.endRefreshingWithNoMoreDataAtTableView(tableView: self.tableView)
                    } else {
                        self.pageIndex += 1;
                    }
                    self.tableView.mj_footer.isHidden = false
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
extension CCQHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.NewsModelList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: imagesCellIDF, for: indexPath) as! CCQHomeListCell
        cell.newsListModel = self.NewsModelList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let newsDetailVC = SYWKWebViewVC(nibName: "SYWKWebViewVC", bundle: nil)
//        newsDetailVC.urlString = "http://www.scdgj.com/danyemian.html"
//
//        navigationController?.pushViewController(newsDetailVC, animated: true)
        
        let newsDetailVC = CCQNewsDetailVC(nibName: "CCQNewsDetailVC", bundle: nil)
        newsDetailVC.urlStrig = self.NewsModelList[indexPath.row].image
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
}
