//
//  AtomicGrindApp.swift
//  AtomicGrind
//
//  Created by Joseph DeWeese on 10/20/24.
//

import SwiftUI
import SwiftData

@main
struct AtomicGrindApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ObjectiveListView()
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Objective.self])
        let config = ModelConfiguration("Objectives", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))

    }
}
