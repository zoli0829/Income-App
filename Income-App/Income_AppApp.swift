//
//  Income_AppApp.swift
//  Income-App
//
//  Created by Zoltan Vegh on 26/09/2025.
//

import SwiftUI

@main
struct Income_AppApp: App {
    
    let dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}
