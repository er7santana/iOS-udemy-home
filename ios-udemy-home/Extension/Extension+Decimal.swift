//
//  Extension+Decimal.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import Foundation

extension Decimal {
    var priceFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: self as NSDecimalNumber) ?? String(describing: self)
    }
}
