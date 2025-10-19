//
//  Currency.swift
//  Income-App
//
//  Created by Zoltan Vegh on 19/10/2025.
//

import Foundation

enum Currency: CaseIterable {
    case usd, eur
    
    var title: String {
        switch self {
        case .usd: return "USD"
        case .eur: return "EUR"
        }
    }
}
