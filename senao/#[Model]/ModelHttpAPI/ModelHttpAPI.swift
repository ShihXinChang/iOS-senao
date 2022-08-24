//
//  ModelHttpAPI.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import Foundation
import RxSwift

class ModelHttpAPI {
    static let shared = ModelHttpAPI()
    
    let apiErrorMessage_Subject = PublishSubject<String>()
    var apiErrorMessage = "" {
        didSet {
            apiErrorMessage_Subject.onNext(apiErrorMessage)
        }
    }
}
