//
//  ResDemoData.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import Foundation

// MARK: - ResDemoData
struct ResDemoData: Codable {
    let data: [DataDetail]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct DataDetail: Codable {
    let price: Int?
    let martShortName: String?
    let imageUrl: String?
    let finalPrice: Int?
    let martName: String?
    let stockAvailable: Int?
    let martId: Int?
    
    enum CodingKeys: String, CodingKey {
        case price
        case martShortName
        case imageUrl
        case finalPrice
        case martName
        case stockAvailable
        case martId
    }
}
