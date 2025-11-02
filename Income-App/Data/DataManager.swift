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
    
    // private so we cant init a new data manager, just use the shared singleton
    private init() {
        container.loadPersistentStores { storeDescription, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
}
