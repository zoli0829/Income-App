//
//  HomeView.swift
//  Income-App
//
//  Created by Zoltan Vegh on 26/09/2025.
//

/*
 1. Object Graph Management
 2. Persistence Store Coordinater
 3. Persistence -> SQLite
 */

/*
 1. Persistence Container -> Entity
 2. DataManager -> Managed Object Context
 3. Create
 4. Read -> FetchRequests
 5. Update
 6. Delete
 7. In Memory Persistence Store (Previews)
 */

import SwiftUI

struct HomeView: View {
    
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: TransactionItem?
    @State private var showSettings = false
    
    @FetchRequest(sortDescriptors: []) var transactions: FetchedResults<TransactionItem>
    
    @AppStorage("orderDescending") var orderDescending = false
    @AppStorage("currency") var currency: Currency = .usd
    @AppStorage("filterMinimum") var filterMinimum = 0.0
    
    @Environment(\.managedObjectContext) private var viewContext

    
    private var displayTransactions: [TransactionItem] {
        let sortedTransactions = orderDescending ? transactions.sorted(by: { $0.wrappedDate < $1.wrappedDate }) : transactions.sorted(by: { $0.wrappedDate > $1.wrappedDate })
        guard filterMinimum > 0 else {
            return sortedTransactions
        }
        let filteredTransactions = sortedTransactions.filter({$0.amount > filterMinimum})
        return filteredTransactions
    }
    
    private var expenses: String {
        let sumExpenses = transactions.filter({ $0.wrappedTransactionType == .expense }).reduce(0, { $0 + $1.amount })
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "$0.00"
    }
    
    var income: String {
        let sumIncome = transactions.filter({ $0.wrappedTransactionType == .income }).reduce(0, { $0 + $1.amount })
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "$0.00"
    }
    
    private var total: String {
        let sumExpenses = transactions.filter({ $0.wrappedTransactionType == .expense }).reduce(0, { $0 + $1.amount })
        let sumIncome = transactions.filter({ $0.wrappedTransactionType == .income }).reduce(0, { $0 + $1.amount })
        let total = sumIncome - sumExpenses
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: total as NSNumber) ?? "$0.00"
    }
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView()
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.white)
                    .padding(.bottom, 7)
            }
            .background(.primaryLightGray)
            .clipShape(Circle())
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.primaryLightGray)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        
                        Text("\(total)")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        Text("\(expenses)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        Text("\(income)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    
                    List {
                        ForEach(displayTransactions) { transaction in
                            TransactionView(transaction: transaction)
                                .foregroundStyle(.black)
                            
//                            Button {
//                                transactionToEdit = transaction
//                            } label: {
//                                TransactionView(transaction: transaction)
//                                    .foregroundStyle(.black)
//                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                .padding()
                
                FloatingButton()
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactionToEdit: transactionToEdit)
            })
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView()
            })
            .sheet(isPresented: $showSettings, content: {
                SettingsView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }
                    
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let transactionToDelete = transactions[index]
            viewContext.delete(transactionToDelete)
        }
    }
}

#Preview {
    HomeView()
}
