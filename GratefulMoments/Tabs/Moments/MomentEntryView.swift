//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by Tejas Patel on 28/04/26.
//

import SwiftUI
import PhotosUI

struct MomentEntryView: View {
    // State properties
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            ScrollView{
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Greatful Moment")
        }
    }
    
    var contentStack: some View {
        VStack(alignment: .leading) {
            TextField("Title (Required)", text: $title)
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .padding(.top, 48)
            Divider()
            TextField("Log your small wins", text: $note, axis: .vertical)
                .multilineTextAlignment(.leading)
                .lineLimit(5...Int.max)
                .fontDesign(.rounded)
            photoPicker
        }
        .padding()
    }
    
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage){
            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color.init(white: 0.4, opacity: 0.32))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .onChange(of: newImage) {
            guard let newImage else { return }
            Task {
                imageData = try await newImage.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    MomentEntryView()
}
