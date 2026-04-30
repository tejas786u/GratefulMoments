//
//  MomentsView.swift
//  GratefulMoments
//
//  Created by Tejas Patel on 30/04/26.
//

import SwiftUI
import SwiftData

struct MomentsView: View {
    @State private var isShowCreateMoment: Bool = false
    @Query(sort: \Moment.timestamp)

    private var moments: [Moment]
    static let offsetAmount: CGFloat = 70.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                pathItems
                    .frame(maxWidth: .infinity)
            }
            .overlay(alignment: .center, content: {
                if moments.isEmpty {
                    ContentUnavailableView {
                        Label("No moments yet!", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("Post a note or photo to start filling this space with gratitude.")
                    }
                }
            })
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowCreateMoment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isShowCreateMoment) {
                        MomentEntryView()
                    }
                }
            }
            .defaultScrollAnchor(.bottom, for: .initialOffset)
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .defaultScrollAnchor(.top, for: .alignment)
            .navigationTitle("Grateful Moments")
        }
    }
    
    private var pathItems: some View {
        ForEach(moments.enumerated(), id: \.0) { index, moment in
            NavigationLink {
                MomentDetailView(moment: moment)
            } label: {
                if moment == moments.last {
                    MomentHexagonView(moment: moment, layout: .large)
                } else {
                    MomentHexagonView(moment: moment)
                        .offset(x: sin(Double(index) * .pi / 2) * Self.offsetAmount)
                }
            }
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
            }
        }
    }
}

#Preview {
    MomentsView()
        .sampleDataContainer()
}

#Preview("No Moment") {
    MomentsView()
        .modelContainer(for: [Moment.self])
        .environment(DataContainer())
}
