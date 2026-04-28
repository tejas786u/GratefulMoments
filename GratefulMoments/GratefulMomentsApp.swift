//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Tejas Patel on 28/04/26.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
