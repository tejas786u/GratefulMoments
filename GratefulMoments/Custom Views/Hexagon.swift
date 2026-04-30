//
//  Hexagon.swift
//  GratefulMoments
//
//  Created by Tejas Patel on 30/04/26.
//

import SwiftUI

struct Hexagon<Content: View>: View {
    var moment: Moment? = nil
    var layout: HexagonLayout = .standard
    private let borderWidth: CGFloat = 2.0
    var borderColor: Color = .ember
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            if let background = moment?.image {
                Image(uiImage: background)
                    .resizable()
                    .scaledToFill()
            }
            content()
                .frame(width: layout.size, height: layout.size)
        }
        .mask({
            Image(systemName: "hexagon.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: layout.size - borderWidth, height: layout.size - borderWidth)
        })
        .background {
            Image(systemName: "hexagon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: layout.size, height: layout.size)
                .foregroundStyle(borderColor)
        }
        .frame(width: layout.size, height: layout.size)
    }
}

#Preview {
    Hexagon(moment: Moment.imageSample, content: {
        Text(Moment.imageSample.title)
            .foregroundStyle(Color.white)
    })
    .sampleDataContainer()
}
