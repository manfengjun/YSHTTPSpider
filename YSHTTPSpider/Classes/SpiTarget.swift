//
//  SpiTarget.swift
//  JJHTTPSpider
//
//  Created by ios on 2019/1/17.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit
import Alamofire
/// SpiderTarget 是 Spider 发出网络请求的配置规则
public protocol SpiTarget {
    /// 发出网络请求的基础地址字符串，默认返回 Spider 中配置的静态变量
    var baseURL: String {get}
    
    /// 网络请求的路径字符串
    var path: String {get}
    
    /// 网络请求的方式，默认返回get
    var method: HTTPMethod {get}
    
    /// 网络请求参数
    var parameters: Parameters? {get}
    
    /// 网络请求头，默认返回 nil
    var headers: HTTPHeaders? {get}
    
    /// 网络请求超时时间，默认返回 Bat 中配置的静态变量
    var timeoutInterval: TimeInterval {get}
    
    /// 是否允许蜂窝数据网络连接，默认返回 Bat 中配置的静态变量
    var allowsCellularAccess: Bool {get}
    
    /// 生成请求后是否立即进行请求，默认返回 Bat 中配置的静态变量
    var startImmediately: Bool {get}
    
    ///编码类型
    var encoderType: SpiEncoderType {get}
    
    
}

//MARK: - extensions

extension SpiTarget {
    public var baseURL: String {
        return SpiManager.config.baseURL ?? self.baseURL
    }
    
    public var headers: HTTPHeaders? {
        return SpiManager.config.httpHeaders
    }
    
    public var timeoutInterval: TimeInterval {
        return SpiManager.config.timeoutInterval ?? 60.0
    }
    
    public var allowsCellularAccess: Bool {
        return SpiManager.config.allowsCellucerAccess ?? true
    }
    
    public var startImmediately: Bool {
        return SpiManager.config.startImmediately ?? true
    }
    
    public var encoderType: SpiEncoderType {
        return SpiManager.config.encoderType ?? .url
    }
    /// 根据当前配置生成 URL
    ///
    /// return:
    /// - URL:  拼接 baseURL 及 path 生成的 url
    /// - BatError: bathURL 或 path 不符合规则
    func asURL() throws -> URL {
        if var url = URL(string: baseURL){
            url.appendPathComponent(path)
            return url
        } else {
            throw SpiError.invalidURL(baseURL: baseURL, path: path)
        }
    }
}

extension SpiTarget{
    /// 根据当前配置生成 URL
    ///
    /// return:
    /// - URL:  拼接 baseURL 及 path 生成的 url
    /// - BatError: bathURL 或 path 不符合规则
//    func asURL() throws -> URL {
//        if var url = URL(string: baseURL){
//            url.appendPathComponent(path)
//            return url
//        } else {
//            throw SpiError.invalidURL(baseURL: baseURL, path: path)
//        }
//    }
}
