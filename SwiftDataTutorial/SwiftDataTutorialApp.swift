//
//  SwiftDataTutorialApp.swift
//  SwiftDataTutorial
//
//  Created by Asif Syeed on 1/10/23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTutorialApp: App {
    
    let container: ModelContainer = {
        let scheme = Schema([Expense.self])
        let container = try! ModelContainer(for: scheme, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
