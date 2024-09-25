//
//  ImageLoader.swift
//  vpd-list-assessment
//
//  Created by Balogun Kayode on 25.09.2024.
//

import SwiftUI

struct ImageLoader<ShapeType: Shape>: View {
    let url: URL?
    let placeholder: Image
    let errorImage: Image
    let size: CGSize
    let imageShape: ShapeType // Use a generic ShapeType

    var body: some View {
        if let url = url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: size.width, height: size.height)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(imageShape) // Use the generic shape
                        .frame(width: size.width, height: size.height)
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    errorImage
                        .resizable()
                        .scaledToFit()
                        .clipShape(imageShape) // Use the generic shape
                        .frame(width: size.width, height: size.height)
                        .aspectRatio(contentMode: .fit)
                    
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            errorImage
                .resizable()
                .scaledToFit()
                .clipShape(imageShape) // Use the generic shape
                .frame(width: size.width, height: size.height)
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    ImageLoader(
        url: URL(string: "https://images.pexels.com/photos/388517/pexels-photo-388517.jpeg?auto=compress&cs=tinysrgb&w=800"),
        placeholder: Image(systemName: "photo"),
        errorImage: Image(systemName: "photo"),
        size: CGSize(width: 100, height: 150),
        imageShape: Circle() // Use Circle as an example
    )
}
