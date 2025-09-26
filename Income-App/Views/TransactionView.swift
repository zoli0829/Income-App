//
//  TransactionView.swift
//  Income-App
//
//  Created by Zoltan Vegh on 26/09/2025.
//

import SwiftUI

struct TransactionView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(transaction.displayDate)
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(.vertical, 5)
            .background(.lightGrayShade.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            HStack {
                Image(systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(transaction.type == .income ? Color.green : Color.red)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(transaction.title)
                            .font(.system(size: 15, weight: .bold))
                        Spacer()
                        Text(String(transaction.displayAmount))
                            .font(.system(size: 15, weight: .bold))
                    }
                }
            }
            Text("Completed")
                .font(.system(size: 14))
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    TransactionView(transaction: Transaction(title: "Apple", type: .expense, amount: 0.99, date: Date()))
}
