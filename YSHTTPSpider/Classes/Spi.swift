//
//  Spi.swift
//  JJHTTPSpider
//
//  Created by ios on 2019/1/17.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit
import Alamofire
open class Spi {
    public let target: SpiTarget
    var parameters: Parameters?
    public init(_ target: SpiTarget){
        self.target = target
        parameters = target.parameters
    }
    public func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: target.asURL())
        
        request.allowsCellularAccess = target.allowsCellularAccess
        request.allHTTPHeaderFields = target.headers
        request.httpMethod = target.method.rawValue
        request.timeoutInterval = target.timeoutInterval
        
        //            features?.forEach{ $0.config(&request) }
        
        var encoder: SpiEncoder!
        switch target.encoderType {
        case .url:
            encoder = URLEncoder()
        case .json:
            encoder = JSONEncoder()
        }
        return try! encoder.encode(request, with: parameters)
    }
    //MARK: - 网络事件操作
    @discardableResult
    public func send() -> DataRequest {
        let asRequest = try! asURLRequest()
        let request = Alamofire.request(asRequest as URLRequestConvertible)
        if (target.startImmediately) {
            request.resume()
        }
        return request

    }

    
}


