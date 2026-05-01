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
    var badgeManager: BadgeManager

    var modelContext: ModelContext {
        modelContainer.mainContext
    }

    init(includeSampleMoments: Bool = false) {
        let schema = Schema([
            Moment.self,
            Badge.self
        ])

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            badgeManager = BadgeManager(modelContainer: modelContainer)
            
            try badgeManager.loadBadgesIfNeeded()

            if includeSampleMoments {
                try loadSampleMoments()
            }
            try modelContext.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    private func loadSampleMoments() throws{
        for moment in Moment.sampleData {
            modelContext.insert(moment)
            try badgeManager.unlockBadges(newMoment: moment)
        }
    }
}

private let sampleContainer = DataContainer(includeSampleMoments: true)

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelContainer)
    }
}
