//
//  SpiManager.swift
//  JJHTTPSpider
//
//  Created by ios on 2019/1/17.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit
import Alamofire
open class SpiManager {
    
    // MARK: - 统一设置
    public struct config {
        public static var baseURL: String?
        public static var httpHeaders: HTTPHeaders?
        public static var startImmediately: Bool?
        public static var allowsCellucerAccess: Bool?
        public static var timeoutInterval: TimeInterval?
        public static var encoderType: SpiEncoderType?
        public static var result_key: RESULT_KEY = RESULT_KEY()

        /// 静态方法，设置 Bat 全局配置
        public static func setConfig(baseURL: String?=nil,
                                     httpHeaders: HTTPHeaders? = nil,
                                     startImmediately: Bool = true,
                                     allowsCellucerAccess: Bool = true,
                                     timeoutInterval: TimeInterval = 60,
                                     encoderType: SpiEncoderType = .url,
                                     result_key: RESULT_KEY) {
            self.baseURL = baseURL
            self.httpHeaders = httpHeaders
            self.startImmediately = startImmediately
            self.allowsCellucerAccess = allowsCellucerAccess
            self.timeoutInterval = timeoutInterval
            self.encoderType = encoderType
            self.result_key = result_key
        }
    }
    
    // MARK: -
    /// session 管理单例
    public static let manager = SpiManager ()
    
    
    
    init() {
        
    }
    
    
}
public struct RESULT_KEY {
    var RESULT_CODE: String = "status"
    var RESULT_MSG: String = "msg"
    var RESULT_DATA: String = "data"
    var RESULT_SUCCESS: Int = 1
    public init(code: String = "status",
                msg: String = "msg",
                data: String = "data",
                success: Int = 0) {
        self.RESULT_CODE = code
        self.RESULT_MSG = msg
        self.RESULT_DATA = data
        self.RESULT_SUCCESS = success
    }
    init() {
        
    }
    
}
