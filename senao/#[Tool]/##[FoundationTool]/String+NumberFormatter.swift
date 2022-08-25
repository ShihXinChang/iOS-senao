//
//  String+NumberFormatter.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/25.
//

import Foundation

extension String {
    /// "12345" -> "$12,345"
    func Convert_To_MoneyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        guard let moneyString = formatter.string(from: NSDecimalNumber(string: self)) else {
            return ""
        }
        return moneyString
    }
}
