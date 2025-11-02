//
//  AddTransactionView.swift
//  Income-App
//
//  Created by Zoltan Vegh on 27/09/2025.
//

import SwiftUI

struct AddTransactionView: View {
    var transactionToEdit: TransactionItem?
    @Binding var transactions: [Transaction]
    @State private var amount: Double = 0.0
    @State private var transactionTitle = ""
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("currency") var currency: Currency = .usd
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
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
                    transactionToEdit.title = transactionTitle
                    transactionToEdit.amount = amount
                    transactionToEdit.type = Int16(selectedTransactionType.rawValue)
                    
                    do {
                        try viewContext.save()
                    } catch {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                } else {
                    
                    let transaction = TransactionItem(context: viewContext)
                    transaction.id = UUID()
                    transaction.title = transactionTitle
                    transaction.type = Int16(selectedTransactionType.rawValue)
                    transaction.amount = amount
                    transaction.date = Date()
                    
                    do {
                        try viewContext.save()
                    } catch {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    
//                    let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
//                    transactions.append(transaction)
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
                transactionTitle = transactionToEdit.wrappedTitle
                selectedTransactionType = transactionToEdit.wrappedTransactionType
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
