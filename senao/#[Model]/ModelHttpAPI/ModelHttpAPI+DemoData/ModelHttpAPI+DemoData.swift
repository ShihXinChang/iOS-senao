//
//  ModelHttpAPI+DemoData.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import Foundation
import RxSwift

extension ModelHttpAPI {
    /// 登入
    static func getDemoData() -> Observable<Void> {
        return Observable<Void>.create { observer in
            let ob = AlamofireTool.shared.getDictionaryParameters(url: URL_DemoData)
            _ = ob.subscribe(onNext: { resTuple in
                
                let statusCode = resTuple.statusCode
                let jsonString = resTuple.jsonString
                let jsonData = Data(jsonString.utf8)
                debugLog("[🌐] statusCode=\(statusCode) jsonString=\(jsonString)")
                
                do {
                    let response = try JSONDecoder().decode(ResDemoData.self, from: jsonData)
                    
                    observer.onNext(())
                    observer.onCompleted()
                    
                    // MARK: 特殊動作
                    /// 資料處理
                    ProductInfoManager.shared.updateResDemoData(resDemoData: response)
                    
                } catch {
                    // JSONDecoder parser error
                    debugLog("[🌐] error=\(error)")
                    ModelHttpAPI.shared.apiErrorMessage = "[\(#function)] \(error)"
                    return observer.onError(error)
                }
                
            }, onError: { error in
                // Network error
                debugLog("[🌐] error=\(error)")
                ModelHttpAPI.shared.apiErrorMessage = "[\(#function)] \(error)"
                return observer.onError(error)
            })
            
            return Disposables.create {
                
            }
        }
    }
}

