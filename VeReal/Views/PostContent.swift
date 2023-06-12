//
//  PostContent.swift
//  VeReal
//
//  Created by Théo Pomies on 6/12/23.
//

import SwiftUI

struct PostContent: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var alignment: Alignment = .topLeading
    @State private var swapped = false

    @Binding var isHovered: Bool
    var hideOverlay: Bool {
        isHovered
    }

    var body: some View {
        ZStack {
            frontImage.opacity(swapped ? 1 : 0)
            backImage.opacity(swapped ? 0 : 1)
        }
        .setBeRealImageType(.large)
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
        .overlay(alignment: alignment) {
            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                withAnimation(.linear(duration: 0.1)) {
                    swapped.toggle()
                }
            } label: {
                ZStack {
                    backImage.opacity(swapped ? 1 : 0)
                    frontImage.opacity(swapped ? 0 : 1)
                }
                .setBeRealImageType(.small)
                .frame(width: 120)
                .opacity(hideOverlay ? 0 : 0.95)
            }
//            .buttonStyle(.noStyle) // TODO: RESOLVE THIS ISSUE
            .padding()
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
    }

    private var backImage: some View {
        PostImage(imageURL: URL(string: "https://i2.wp.com/anniewearsit.com/wp-content/uploads/2018/03/GOPR0040.jpg?w=4476&h=3357&ssl=1")!)
    }

    private var frontImage: some View {
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

struct NoStyleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

extension ButtonStyle where Self == NoStyleButtonStyle {
    static var noStyle: NoStyleButtonStyle { NoStyleButtonStyle() }
}
