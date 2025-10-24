//
//  Currency.swift
//  Income-App
//
//  Created by Zoltan Vegh on 19/10/2025.
//

import Foundation

enum Currency: Int, CaseIterable {
    case usd, eur, pounds
    
    var title: String {
        switch self {
        case .usd: return "USD"
        case .eur: return "EUR"
        case .pounds: return "GBP"
        }
    }
    
    var locale: Locale {
        switch self {
        case .usd: return Locale(identifier: "en_US")
        case .eur: return Locale(identifier: "de_DE")
        case .pounds: return Locale(identifier: "en_GB")
        }
    }
}
