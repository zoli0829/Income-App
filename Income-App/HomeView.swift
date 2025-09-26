//
//  HomeView.swift
//  Income-App
//
//  Created by Zoltan Vegh on 26/09/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(transactions) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
