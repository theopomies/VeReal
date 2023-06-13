//
//  PostContent.swift
//  VeReal
//
//  Created by Théo Pomies on 6/12/23.
//

import SwiftUI

struct PostContent: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var swapped = false

    @Binding var isHovered: Bool
    @State private var magnification = 1.0
    @State private var isMagnifying = false

    @State private var translation: CGSize = .zero

    var hideOverlay: Bool {
        isHovered || isMagnifying
    }

    var body: some View {
        ZStack {
            frontImage.opacity(swapped ? 1 : 0)
            backImage.opacity(swapped ? 0 : 1)
        }
        .scaleEffect(magnification)
        .setBeRealImageType(.large)
        .gesture(
            MagnificationGesture()
                .onChanged { m in
                    magnification = m > 1 ? m : 1
                    isMagnifying = true
                }
                .onEnded { _ in
                    magnification = 1
                    isMagnifying = false
                }
        )
        .delaysTouches(for: 0.2)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    isHovered = true
                }
                .onEnded { _ in
                    isHovered = false
                }
        )
        .overlay {
            PostPictureOverlay(swapped: $swapped, hideOverlay: hideOverlay, backImage: backImage, frontImage: frontImage)
        }
        .overlay(alignment: .bottomTrailing) {
            VStack(spacing: 20) {
                Image(systemName: "bubble.left.fill")
                Image(systemName: colorScheme == .light ? "smiley.fill" : "smiley")
                    .onTapGesture {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
            }
            .shadow(radius: 5)
            .font(.title2)
            .opacity(hideOverlay ? 0 : 0.95)
            .padding()
        }
        .animation(hideOverlay ? .linear(duration: 0.25) : .linear(duration: 0.1), value: hideOverlay)
    }

    private var backImage: PostImage {
        PostImage(imageURL: URL(string: "https://i2.wp.com/anniewearsit.com/wp-content/uploads/2018/03/GOPR0040.jpg?w=4476&h=3357&ssl=1")!)
    }

    private var frontImage: PostImage {
        PostImage(imageURL: URL(string: "https://i.pinimg.com/736x/83/c4/c5/83c4c56061a4360654977e33b87b2013.jpg")!)
    }
}

struct PostContent_Previews: PreviewProvider {
    static var previews: some View {
        PostContent(isHovered: .constant(false))
            .background(.black)
            .foregroundColor(.white)
    }
}
