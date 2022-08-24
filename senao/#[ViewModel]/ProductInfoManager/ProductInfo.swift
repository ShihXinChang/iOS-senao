//
//  ProductInfo.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import Foundation

@objc class ProductInfo: NSObject {
    /// 圖片網址
    private(set) var imageURL: String = ""

    /// 價格 (Int -> String format $XX,XXX)
    private(set) var finalPrice: String = "" // int -> $39,950
    
    /// 商品名稱
    private(set) var martName: String = ""
    
    /// 商品編號 (商品編號：XXXXX)
    private(set) var martId: String = ""
    
    init(dataDetail: DataDetail?) {
        super.init()

        guard let dataDetail = dataDetail else {
            return
        }
        
        imageURL = dataDetail.imageUrl ?? ""
        
        finalPrice = (dataDetail.finalPrice != nil) ? "\(dataDetail.finalPrice!)" : ""
        
        martName = dataDetail.martName ?? ""
        
        martId = (dataDetail.martId != nil) ? "商品編號：\(dataDetail.martId!)" : "商品編號：無"
    }
    
}
