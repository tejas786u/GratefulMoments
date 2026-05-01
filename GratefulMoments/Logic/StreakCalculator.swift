//
//  StreakCalculator.swift
//  GratefulMoments
//
//  Created by Tejas Patel on 01/05/26.
//

import Foundation

struct StreakCalculator {
    let calendar = Calendar.current
    
    func calculateStreak(_ moments: [Moment]) -> Int {
        let startOfToday = calendar.startOfDay(for: .now)
        let endOfToday = calendar.date(byAdding: DateComponents(day: 1, second: -1), to: startOfToday)!
        
        let daysAgoArray = moments
            .reversed()
            .map(\.timestamp)
            .map { calendar.dateComponents([.day], from: $0, to: endOfToday) }
            .compactMap { $0.day }
        
        var streak = 0
        for daysAgo in daysAgoArray {
            if daysAgo == streak {
                streak += 1
            }
        }
        return streak
    }
}
