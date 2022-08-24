//
//  AlamofireTool.swift
//  DriverApp
//
//  Created by 張仕欣 on 2021/12/5.
//

import Foundation
import Alamofire
import RxSwift

enum ParameterEncodeMode: Int {
    case JSONEncodable
    case defaultURLEncode
    case queryStringEncode
}

class AlamofireTool: NSObject {
    static let shared = AlamofireTool()

    let session: Session!
    
    override init() {
        // Create a non-caching configuration.
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.headers = [:]
        configuration.urlCache = nil
        session = Session(configuration: configuration)
    }
    
    func postEncodableParameters<Parameters: Encodable>(url: String,
                                                        headers: [String: String] = [:],
                                                        parameters: Parameters,
                                                        encodeMode: ParameterEncodeMode = .JSONEncodable) -> Observable<(statusCode: Int, jsonString: String)> {
        
        let httpHeaders = HTTPHeaders(headers)
        var encoder: ParameterEncoder = JSONParameterEncoder.default
        switch encodeMode {
        case .JSONEncodable:
            break
        case .defaultURLEncode:
            encoder = URLEncodedFormParameterEncoder.default
        case .queryStringEncode:
            encoder = URLEncodedFormParameterEncoder(destination: .queryString)
        }
        
        var emptyResponseCodes = DataResponseSerializer.defaultEmptyResponseCodes
        // MARK: 解決 statusCode = 200，但回應 .failure 的問題
        emptyResponseCodes.insert(200)
        // MARK: 解決 statusCode = 401(token 驗證失敗)，但回應 .failure 的問題
        emptyResponseCodes.insert(401)

        let observable = Observable<(statusCode: Int, jsonString: String)>.create { observer in
            self.session.request(url,
                                 method: .post,
                                 parameters: parameters,
                                 encoder: encoder,
                                 headers: httpHeaders).responseString(emptyResponseCodes: emptyResponseCodes, completionHandler: { response in
                
                let statusCode = response.response?.statusCode ?? -1
                
                switch response.result {
                case .success(let jsonString):
                    observer.onNext((statusCode, jsonString))
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                    break
                }
            })
            return Disposables.create()
        }
        return observable
    }
    
    func postDictionaryParameters(url: String,
                                  headers: [String: String] = [:],
                                  parameters: [String : Any]? = nil,
                                  encodeMode: ParameterEncodeMode = .defaultURLEncode) -> Observable<(statusCode: Int, jsonString: String)> {
        let httpHeaders = HTTPHeaders(headers)
        var encoding: ParameterEncoding = URLEncoding.default
        switch encodeMode {
        case .JSONEncodable:
            break
        case .defaultURLEncode:
            break
        case .queryStringEncode:
            encoding = URLEncoding(destination: .queryString)
            break
        }
        
        // MARK: 解決 statusCode = 200，但回應 .failure 的問題
        var emptyResponseCodes = DataResponseSerializer.defaultEmptyResponseCodes
        emptyResponseCodes.insert(200)
        // MARK: 解決 statusCode = 401(token 驗證失敗)，但回應 .failure 的問題
        emptyResponseCodes.insert(401)
        
        let observable = Observable<(statusCode: Int, jsonString: String)>.create { observer in
            self.session.request(url,
                                 method: .post,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: httpHeaders).responseString(emptyResponseCodes: emptyResponseCodes, completionHandler: { response in
               
                let statusCode = response.response?.statusCode ?? -1
                
                switch response.result {
                case .success(let jsonString):
                    observer.onNext((statusCode, jsonString))
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                    break
                }
            })
            return Disposables.create()
        }
        return observable
    }

    
    func getEncodableParameters<Parameters: Encodable>(url: String,
                                                       headers: [String: String] = [:],
                                                       parameters: Parameters) -> Observable<(statusCode: Int, jsonString: String)> {
        let httpHeaders = HTTPHeaders(headers)
        
        var emptyResponseCodes = DataResponseSerializer.defaultEmptyResponseCodes
        // MARK: 解決 statusCode = 200，但回應 .failure 的問題
        emptyResponseCodes.insert(200)
        // MARK: 解決 statusCode = 401(token 驗證失敗)，但回應 .failure 的問題
        emptyResponseCodes.insert(401)

        let observable = Observable<(statusCode: Int, jsonString: String)>.create { observer in
            self.session.request(url,
                                 method: .get,
                                 parameters: parameters,
                                 headers: httpHeaders).responseString(emptyResponseCodes: emptyResponseCodes, completionHandler: { response in
                
                let statusCode = response.response?.statusCode ?? -1
                
                switch response.result {
                case .success(let jsonString):
                    observer.onNext((statusCode, jsonString))
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                    break
                }
            })
            return Disposables.create()
        }
        return observable
    }
    
    func getDictionaryParameters(url: String,
                                 headers: [String: String] = [:],
                                 parameters: [String : Any]? = nil) -> Observable<(statusCode: Int, jsonString: String)> {
        let httpHeaders = HTTPHeaders(headers)

        var emptyResponseCodes = DataResponseSerializer.defaultEmptyResponseCodes
        // MARK: 解決 statusCode = 200，但回應 .failure 的問題
        emptyResponseCodes.insert(200)
        // MARK: 解決 statusCode = 401(token 驗證失敗)，但回應 .failure 的問題
        emptyResponseCodes.insert(401)
        
        let observable = Observable<(statusCode: Int, jsonString: String)>.create { observer in
            self.session.request(url,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding(destination: .methodDependent),
                                 headers: httpHeaders).responseString(emptyResponseCodes: emptyResponseCodes, completionHandler: { response in
               
                let statusCode = response.response?.statusCode ?? -1
                
                switch response.result {
                case .success(let jsonString):
                    observer.onNext((statusCode, jsonString))
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                    break
                }
            })
            return Disposables.create()
        }
        return observable
    }
    
    
    func putDictionaryParameters(url: String,
                                 headers: [String: String] = [:],
                                 parameters: [String : Any]? = nil) -> Observable<(statusCode: Int, jsonString: String)> {
        let httpHeaders = HTTPHeaders(headers)

        var emptyResponseCodes = DataResponseSerializer.defaultEmptyResponseCodes
        // MARK: 解決 statusCode = 200，但回應 .failure 的問題
        emptyResponseCodes.insert(200)
        // MARK: 解決 statusCode = 401(token 驗證失敗)，但回應 .failure 的問題
        emptyResponseCodes.insert(401)
        
        let observable = Observable<(statusCode: Int, jsonString: String)>.create { observer in
            self.session.request(url,
                                 method: .put,
                                 parameters: parameters,
                                 headers: httpHeaders).responseString(emptyResponseCodes: emptyResponseCodes, completionHandler: { response in
               
                let statusCode = response.response?.statusCode ?? -1
                
                switch response.result {
                case .success(let jsonString):
                    observer.onNext((statusCode, jsonString))
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                    break
                }
            })
            return Disposables.create()
        }
        return observable
    }
    
    func putEncodableParameters<Parameters: Encodable>(url: String,
                                                       headers: [String: String] = [:],
                                                       parameters: Parameters,
                                                       encodeMode: ParameterEncodeMode = .JSONEncodable) -> Observable<(statusCode: Int, jsonString: String)> {
        
        let httpHeaders = HTTPHeaders(headers)
        var encoder: ParameterEncoder = JSONParameterEncoder.default
        switch encodeMode {
        case .JSONEncodable:
            break
        case .defaultURLEncode:
            encoder = URLEncodedFormParameterEncoder.default
        case .queryStringEncode:
            encoder = URLEncodedFormParameterEncoder(destination: .queryString)
        }
        
        var emptyResponseCodes = DataResponseSerializer.defaultEmptyResponseCodes
        // MARK: 解決 statusCode = 200，但回應 .failure 的問題
        emptyResponseCodes.insert(200)
        // MARK: 解決 statusCode = 401(token 驗證失敗)，但回應 .failure 的問題
        emptyResponseCodes.insert(401)
        
        let observable = Observable<(statusCode: Int, jsonString: String)>.create { observer in
            self.session.request(url,
                                 method: .put,
                                 parameters: parameters,
                                 encoder: encoder,
                                 headers: httpHeaders).responseString(emptyResponseCodes: emptyResponseCodes, completionHandler: { response in
                
                let statusCode = response.response?.statusCode ?? -1
                
                switch response.result {
                case .success(let jsonString):
                    observer.onNext((statusCode, jsonString))
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                    break
                }
            })
            return Disposables.create()
        }
        return observable
    }
}
