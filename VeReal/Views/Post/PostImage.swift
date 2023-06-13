//
//  PostImage.swift
//  VeReal
//
//  Created by Théo Pomies on 6/11/23.
//

import SwiftUI

struct PostImage: View {
    let imageURL: URL
    let isSmaller: Bool

    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFill()
                .aspectRatio(0.75, contentMode: .fill)
        } placeholder: {
            // Placeholder view here - this should match the size and aspect ratio of your image.
            Rectangle().fill(.black)
                .aspectRatio(0.75, contentMode: .fill)
        }
        .clipped()
        .frame(minWidth: 0, maxWidth: .infinity)
    }

    init(imageURL: URL, isSmall: Bool = false) {
        self.imageURL = imageURL
        self.isSmaller = isSmall
    }
}

struct BeRealImage_Previews: PreviewProvider {
    static var previews: some View {
        PostImage(imageURL: URL(string: "https://i2.wp.com/anniewearsit.com/wp-content/uploads/2018/03/GOPR0040.jpg?w=4476&h=3357&ssl=1")!)
    }
}

extension View {
    func setBeRealImageType(_ imageType: SetBeRealImageType.BeRealImageType) -> some View {
        modifier(SetBeRealImageType(imageType: imageType))
    }
}

struct SetBeRealImageType: ViewModifier {
    enum BeRealImageType {
        case large
        case small

        var isSmall: Bool {
            self == .small
        }
    }

    let imageType: BeRealImageType

    func body(content: Content) -> some View {
        content
            .cornerRadius(imageType.isSmall ? 15 : 20)
            .overlay(
                RoundedRectangle(cornerRadius: imageType.isSmall ? 15 : 20)
                    .stroke(Color.black, lineWidth: 2)
            )
            .aspectRatio(1, contentMode: .fit)
    }
}
