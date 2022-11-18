//
//  PlannerApp.swift
//  Planner
//
//  Created by Sandy Lee on 11/18/22.
//

import SwiftUI

@main
struct PlannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
