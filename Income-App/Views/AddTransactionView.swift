//
//  AddTransactionView.swift
//  Income-App
//
//  Created by Zoltan Vegh on 27/09/2025.
//

import SwiftUI

struct AddTransactionView: View {
    var transactionToEdit: Transaction?
    @Binding var transactions: [Transaction]
    @State private var amount: Double = 0.0
    @State private var transactionTitle = ""
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60))
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Divider()
                .padding(.horizontal, 30)
            
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            
            Button {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid title"
                    alertMessage = "Title message should be 2 or more characters long"
                    showAlert = true
                    return
                }
                
                let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                
                if let transactionToEdit {
                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit) else {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = transaction
                } else {
                    transactions.append(transaction)
                }
                
                dismiss()
                
            } label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(.primaryLightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.top)
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .onAppear(perform: {
            if let transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                selectedTransactionType = transactionToEdit.type
            }
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("OK")
            }
        } message: {
            Text(alertMessage)
        }

    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
