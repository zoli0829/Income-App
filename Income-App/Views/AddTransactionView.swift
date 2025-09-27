//
//  AddTransactionView.swift
//  Income-App
//
//  Created by Zoltan Vegh on 27/09/2025.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount: Double = 0.0
    
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
            Spacer()
        }
    }
}

#Preview {
    AddTransactionView()
}
