//
//  SpiDataRequest.swift
//  Alamofire
//
//  Created by JUN on 2019/3/3.
//

import UIKit
import Alamofire
import HandyJSON

public struct ObjectResponseSerializer<Value: HandyJSON>: DataResponseSerializerProtocol {
    
    public typealias SerializedObject = Value
    
    public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<Value>
    
    public init(serializeResponse: @escaping (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<Value>) {
        self.serializeResponse = serializeResponse
    }
}
public protocol DataResponsesSerializerProtocol {
    associatedtype SerializedObject
    
    var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<[SerializedObject]> { get }
}
public struct ObjectsResponseSerializer<Value>: DataResponsesSerializerProtocol {
    public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<[Value]>
    
    public typealias SerializedObject = Value
    

    public init(serializeResponse: @escaping (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<[Value]>) {
        self.serializeResponse = serializeResponse
    }
}

// MARK: - 解析JSON
extension DataRequest {
    public static func spiJsonSerializer(
        options: JSONSerialization.ReadingOptions = .allowFragments)
        -> DataResponseSerializer<Any>
    {
        return DataResponseSerializer { _, response, data, error in
            return Request.serializeCodeResponseJSON(options: options, response: response, data: data, error: error)
        }
    }
    
    /// 解析JSON
    ///
    /// - Parameters:
    ///   - queue:
    ///   - options:
    ///   - completionHandler:
    /// - Returns: 
    @discardableResult
    public func spiResponseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler: @escaping (DataResponse<Any>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: DataRequest.spiJsonSerializer(options: options),
            completionHandler: completionHandler
        )
    }
}

// MARK: - 解析对象
extension DataRequest {
    public static func spiObjectSerializer<T: HandyJSON>(
        options: JSONSerialization.ReadingOptions = .allowFragments, designatedPath: String? = nil)
        -> ObjectResponseSerializer<T>
    {
        return ObjectResponseSerializer(serializeResponse: { (request, response, data, error) -> Result<T> in
            let serializeResponse = Request.serializeCodeResponseJSON(options: options, response: response, data: data, error: error)
            switch serializeResponse {
            case .success(let value):
                if let json = value as? [String:Any] {
                    if let value = json[SpiManager.config.result_key.RESULT_DATA] as? T {
                        return .success(value)
                    } else if let object = json[SpiManager.config.result_key.RESULT_DATA] {
                        if let model = designatedPath == nil ? T.self.deserialize(from: object as? [String:Any]) : T.self.deserialize(from: object as? [String:Any], designatedPath: designatedPath){
                            return .success(model)
                        }
                        else {
                            return .failure(SpiError.responseSerializationFailed(reason: .objectFailed))
                            
                        }
                    } else {
                        return .failure(SpiError.responseSerializationFailed(reason: .dataLengthIsZero))
                    }
                }
                else {
                    return .failure(SpiError.responseSerializationFailed(reason: .objectFailed))

                }
                
            case .failure(let error):
                return .failure(error)
            }
        })
        
    }
    
    /// 解析Object
    ///
    /// - Parameters:
    ///   - designatedPath: 解析路径
    ///   - queue:
    ///   - options:
    ///   - completionHandler:
    /// - Returns:
    @discardableResult
    public func spiResponseObject<T: HandyJSON>(designatedPath: String? = nil, queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(responseSerializer: DataRequest.spiObjectSerializer(options: options), completionHandler: completionHandler)
    }
}
// MARK: - 解析对象数组
extension DataRequest {
    public static func spiObjectsSerializer<T: HandyJSON>(
        options: JSONSerialization.ReadingOptions = .allowFragments, designa tedPath: String? = nil)
        -> ObjectsResponseSerializer<[T]>
    {
        return ObjectsResponseSerializer(serializeResponse: { (request, response, data, error) -> Result<[T]> in
            let serializeResponse = Request.serializeCodeResponseJSON(options: options, response: response, data: data, error: error)
            switch serializeResponse {
            case .success(let value):
                if let json = value as? [String:Any] {
                    if let value = json[SpiManager.config.result_key.RESULT_DATA] as? [T] {
                        return .success(value)
                    } else if let object = json[SpiManager.config.result_key.RESULT_DATA] {
                        if let model = designatedPath == nil ? [T].self.deserialize(from: object as? [String:Any]) : [T].self.deserialize(from: object as? [String:Any], designatedPath: designatedPath){
                            return .success(model)
                        }
                        else {
                            return .failure(SpiError.responseSerializationFailed(reason: .objectFailed))
                            
                        }
                    } else {
                        return .failure(SpiError.responseSerializationFailed(reason: .dataLengthIsZero))
                    }
                }
                else {
                    return .failure(SpiError.responseSerializationFailed(reason: .objectFailed))
                    
                }
                
            case .failure(let error):
                return .failure(error)
            }
        })
        
    }
    
    /// 解析Object
    ///
    /// - Parameters:
    ///   - designatedPath: 解析路径
    ///   - queue:
    ///   - options:
    ///   - completionHandler:
    /// - Returns:
    @discardableResult
    public func spiResponseObjects<T: HandyJSON>(designatedPath: String? = nil, queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        return response(responseSerializer: DataRequest.spiObjectSerializer(options: options), completionHandler: completionHandler)
    }
}

extension Request {
    public static func serializeCodeResponseJSON(
        options: JSONSerialization.ReadingOptions,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?)
        -> Result<Any>
    {
        guard error == nil else { return .failure(error!) }
        if let response = response, emptyDataStatusCodes.contains(response.statusCode) { return .success([:]) }
        guard let validData = data, validData.count > 0 else {
            return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
        }
        do {
            let jsonData = try JSONSerialization.jsonObject(with: validData, options: options)
            if let json = jsonData as? [String:Any] {
                if let status = json[SpiManager.config.result_key.RESULT_CODE] as? Int, (status == SpiManager.config.result_key.RESULT_SUCCESS){
                    return .success(json)
                } else {
                    if let status = json[SpiManager.config.result_key.RESULT_CODE] as? Int {
                        return .failure(SpiError.executeFailed(reason: .executeFail(code: status, msg: json[SpiManager.config.result_key.RESULT_MSG] as? String)))
                    }
                    return .failure(SpiError.executeFailed(reason: .unlegal))
                }
            }
            return .failure(SpiError.responseSerializationFailed(reason: .jsonIsNotADictionary))
            
        } catch {
            return .failure(SpiError.responseSerializationFailed(reason: .jsonSerializationFailed(error)))
        }
    }
}
private let emptyDataStatusCodes: Set<Int> = [204, 205]
