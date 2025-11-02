//
//  TransactionView.swift
//  Income-App
//
//  Created by Zoltan Vegh on 26/09/2025.
//

import SwiftUI

struct TransactionView: View {
    let transaction: TransactionItem
    @AppStorage("currency") var currency: Currency = .usd
    
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
                Image(systemName: transaction.wrappedTransactionType == .income ? "arrow.up.forward" : "arrow.down.forward")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(transaction.wrappedTransactionType == .income ? Color.green : Color.red)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(transaction.wrappedTitle)
                            .font(.system(size: 15, weight: .bold))
                        Spacer()
                        Text(String(transaction.display(currency: currency)))
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

//#Preview {
//    TransactionView(transaction: TransactionItem(title: "Apple", type: .expense, amount: 0.99, date: Date()))
//}
