//
//  ProductInfoManager.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import Foundation
import RxSwift

class ProductInfoManager: NSObject {
    // MARK: Parameter (public)
    /// Singleton
    static let shared = ProductInfoManager()
    
    /// 商品資料
    let productArray_Subject = BehaviorSubject(value: [ProductInfo]())
    private var _productArray = [ProductInfo]()
    private(set) var productArray: [ProductInfo] {
        get {
            synchronized(self) {
                return _productArray
            }
        }
        set {
            synchronized(self) {
                _productArray = newValue
                productArray_Subject.onNext(_productArray)
            }
        }
    }
    
    /// UI 流程暫存用
    var selectedProductInfo: ProductInfo?

    override init() {
        super.init()
    }
    
    /// 更新商品資料
    func updateResDemoData(resDemoData: ResDemoData) {
        synchronized(self) {
            var tempArray = [ProductInfo]()

            guard let dataArray = resDemoData.data else {
                productArray = tempArray
                return
            }
            
            for dataDetail in dataArray {
                let productInfo = ProductInfo(dataDetail: dataDetail)
                tempArray.append(productInfo)
            }
            productArray = tempArray
        }
    }
}

// thread-safe support
extension ProductInfoManager {
    private func synchronized<T>(_ lock: AnyObject, _ closure: () throws -> T) rethrows -> T {
        objc_sync_enter(lock)
        defer { objc_sync_exit(lock) }
        return try closure()
    }
}
