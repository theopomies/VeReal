//
//  PostView.swift
//  VeReal
//
//  Created by Théo Pomies on 6/11/23.
//

import SwiftUI

struct PostView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var alignment: Alignment = .topLeading
    @State private var hideOverlay: Bool = false
    @State private var swapped = false

    var body: some View {
        VStack {
            PostHeader()

            ZStack {
                frontImage.opacity(swapped ? 1 : 0)
                backImage.opacity(swapped ? 0 : 1)
            }
            .setBeRealImageType(.large)
            .delaysTouches(for: 0.2)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        hideOverlay = true
                    }
                    .onEnded { _ in
                        hideOverlay = false
                    }
            )
            .overlay(alignment: alignment) {
                ZStack {
                    backImage.opacity(swapped ? 1 : 0)
                    frontImage.opacity(swapped ? 0 : 1)
                }
                .setBeRealImageType(.small)
                .frame(width: 120)
                .opacity(hideOverlay ? 0 : 0.95)
                .padding()
                .onTapGesture {
                    swapped.toggle()
                }
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
            .animation(hideOverlay ? .linear(duration: 0.3) : .linear(duration: 0.1), value: hideOverlay)

            PostFooter()
        }
    }

    private var backImage: some View {
        PostImage(imageURL: URL(string: "https://i2.wp.com/anniewearsit.com/wp-content/uploads/2018/03/GOPR0040.jpg?w=4476&h=3357&ssl=1")!)
    }

    private var frontImage: some View {
        PostImage(imageURL: URL(string: "https://i.pinimg.com/736x/83/c4/c5/83c4c56061a4360654977e33b87b2013.jpg")!)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
            .background(.black)
            .foregroundColor(.white)
    }
}
