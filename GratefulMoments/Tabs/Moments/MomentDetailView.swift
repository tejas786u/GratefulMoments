//
//  MomentDetailView.swift
//  GratefulMoments
//
//  Created by Tejas Patel on 30/04/26.
//

import SwiftUI
import SwiftData

struct MomentDetailView: View {
    @State private var showConfirmation: Bool = false
    @Environment(DataContainer.self) private var dataContainer
    @Environment(\.dismiss) private var dismiss
    var moment: Moment
    var body: some View {
        ScrollView{
            contentStack
        }
        .navigationTitle(moment.title)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button {
                    showConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
                .confirmationDialog("Are you sure?", isPresented: $showConfirmation) {
                    Button("Delete Moment", role: .destructive) {
                        dataContainer.modelContext.delete(moment)
                        try? dataContainer.modelContext.save()
                        dismiss()
                    }
                } message: {
                    Text("The moment will be permanently deleted. Earned badges won't be removed.")
                }
            }
        }
    }
    
    private var contentStack: some View {
        VStack(alignment: .leading) {
            Text(moment.timestamp, style: .date)
                .font(.subheadline)
                .fontDesign(.rounded)
            if !moment.note.isEmpty{
                Text(moment.note)
                    .textSelection(.enabled)
                    .fontDesign(.rounded)
            }
            if let image = moment.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    NavigationStack {
        MomentDetailView(moment: .imageSample)
            .sampleDataContainer()
    }
}
