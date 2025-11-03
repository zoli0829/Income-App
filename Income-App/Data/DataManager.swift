//
//  DataManager.swift
//  Income-App
//
//  Created by Zoltan Vegh on 27/10/2025.
//

import Foundation
import CoreData

class DataManager {
    
    let container = NSPersistentContainer(name: "IncomeData")
    static let shared = DataManager()
    static var sharedPreview: DataManager {
        let manager = DataManager(inMemory: true)
        
        // dummy data
        let transaction = TransactionItem(context: manager.container.viewContext)
        transaction.title = "Lunch"
        transaction.amount = 10.00
        transaction.type = Int16(TransactionType.expense.rawValue)
        transaction.date = Date()
        transaction.id = UUID()
        
        return manager
    }
    
    // private so we cant init a new data manager, just use the shared singleton
    private init(inMemory: Bool = false) {
        // so we can store data in temporary storage in previews
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
}
