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

    /// 價格（無格式）
    private(set) var price: String = "" // int -> $39,950

    /// 價格（錢格式 $XX,XXX）
    private(set) var price_moneyFormat: String = ""

    /// 商品名稱
    private(set) var name: String = ""
    
    /// 商品編號（商品編號：XXXXX）
    private(set) var idNumber: String = ""
    
    init(dataDetail: DataDetail?) {
        super.init()

        guard let dataDetail = dataDetail else {
            return
        }
        
        imageURL = dataDetail.imageUrl ?? ""
        
        price = (dataDetail.finalPrice != nil) ? "\(dataDetail.finalPrice!)" : ""
        price_moneyFormat = price.Convert_To_MoneyFormat()
        
        name = dataDetail.martName ?? ""
        
        idNumber = (dataDetail.martId != nil) ? "商品編號：\(dataDetail.martId!)" : "商品編號：無"
    }
    
}
