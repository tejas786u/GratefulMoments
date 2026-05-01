//
//  BadgeDetailView.swift
//  GratefulMoments
//
//  Created by Tejas Patel on 01/05/26.
//

import SwiftUI

struct BadgeDetailView: View {
    var badge: Badge
    
    var body: some View {
        VStack(spacing: 8) {
            Image(badge.details.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, height: 140)
            Text(badge.details.title)
                .font(.title.bold())
            Text(badge.details.congratulatoryMessage)
                .font(.body)
            Spacer()
            if let timestamp = badge.timestamp {
                Text(timestamp, style: .date)
                    .font(.caption2.bold())
            }
        }
        .padding()
        .frame(width: 320, height: 410)
        .multilineTextAlignment(.center)
        .foregroundStyle(Color.white)
        .background(badge.details.color.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
}

#Preview {
    BadgeDetailView(badge: .sample)
}
