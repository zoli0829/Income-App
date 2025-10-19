//
//  SettingsView.swift
//  Income-App
//
//  Created by Zoltan Vegh on 19/10/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("orderDescending") private var orderDescending = false
    @State private var currency: Currency = .usd
    @State private var filterMinimum = 0.0
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Toggle(isOn: $orderDescending) {
                        Text("Order \(orderDescending ? "(Earliest)" : "(Latest)")")
                    }
                }
                
                HStack {
                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.title)
                        }
                    }
                }
                
                HStack {
                    Text("Filter Minimum")
                    
                    TextField("", value: $filterMinimum, formatter: numberFormatter)
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle("Settings") // introduce it to the next element following the NavigationStack
        }
    }
}

#Preview {
    SettingsView()
}
