//
//  TransactionTypeModel.swift
//  Income-App
//
//  Created by Zoltan Vegh on 26/09/2025.
//

import Foundation

enum TransactionType: Int, CaseIterable, Identifiable {
    case income, expense
    var id: Self { self }
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
