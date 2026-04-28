//
//  DataContainer.swift
//  GratefulMoments
//
//  Created by Tejas Patel on 28/04/26.
//

import Foundation
import SwiftData
import SwiftUI

/*
 The @Observable macro tells SwiftUI to watch DataContainer for changes. You add the container to the environment so the model container and any future properties on DataContainer are available through the view hierarchy.
 */
@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer
    var modelContext: ModelContext {
        modelContainer.mainContext
    }
    init(includeSampleMoments: Bool = false) {
        let schema = Schema([
            Moment.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            if includeSampleMoments {
                loadSampleMoments()
            }
            try modelContext.save()
        } catch {
            fatalError("Could not create model container : \(error.localizedDescription)")
        }
    }
    
    private func loadSampleMoments() {
        for moment in Moment.sampleData {
            modelContext.insert(moment)
        }
    }
}

/*
 With the .sampleDataContainer() convenience modifier, you don’t need to manually create a data container in every preview: You can add .sampleDataContainer() to provide your sample data. Marking the DataContainer class with @MainActor ensures that any interactions with the container from your views happen on the main thread, which is required for UI updates.
 */

private let sampleContainer = DataContainer(includeSampleMoments: true)

extension View {
    func sampleDataContainer() -> some View {
        self.modelContainer(sampleContainer.modelContainer)
            .environment(sampleContainer)
    }
}
