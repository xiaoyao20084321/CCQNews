//
//  CCQHttpRequestManager.swift
//  CCQNews
//
//  Created by test on 2019/3/30.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit
import AFNetworking

enum CCQHTTPMethod {
    case GET
    case POST
}
class CCQHttpRequestManager: AFHTTPSessionManager {
    /// 静态区／常量／闭包
    /// 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
    static let shared: CCQHttpRequestManager = {
        // 实例化对象
        let instance = CCQHttpRequestManager()
        // 设置响应反序列化支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        // 返回对象
        return instance
    }()
    func request(method: CCQHTTPMethod = .GET, urlString: String, parameters: [String : AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool)->()) -> CCQURLSessionDataTask?{
        
        if method == .GET {
            let task = get(urlString, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, json: Any?) in
                completion(json, true)
            }) { (task: URLSessionDataTask?, error: Error) in
                completion(nil, false)
            }
            return task as? CCQURLSessionDataTask
        } else {
            let task = post(urlString, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, json: Any?) in
                completion(json, true)
            }) { (task: URLSessionDataTask?, error: Error) in
                completion(nil, false)
            }
            return task as? CCQURLSessionDataTask
        }
    }
    
}
