//
//  PostPictureOverlay.swift
//  VeReal
//
//  Created by Théo Pomies on 6/12/23.
//

import SwiftUI

struct PostPictureOverlay: View {
    @Binding var swapped: Bool
    var hideOverlay: Bool
    var backImage: PostImage
    var frontImage: PostImage

    private static let topLeading: CGPoint = .init(x: 120 / 2, y: 120 / 0.75 / 2) // Top
    @State private var position: CGPoint = Self.topLeading

    private func getTopTrailingFrom(containingFrameMaxX: CGFloat) -> CGPoint {
        .init(x: containingFrameMaxX - 120 / 2, y: Self.topLeading.y)
    }

    var body: some View {
        GeometryReader { proxy in
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
                .opacity(hideOverlay ? 0 : 1)
            }
            .position(position)
            .disabled(true)
            .highPriorityGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { change in
                        if change.translation.equalTo(.zero) {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            withAnimation(.linear(duration: 0.1)) {
                                swapped.toggle()
                            }
                        }
                    }
                    .simultaneously(with: DragGesture()
                        .onChanged { change in
                            position = change.location
                        }
                        .onEnded { change in
                            withAnimation(.linear(duration: 0.2)) {
                                if change.location.x > proxy.size.width / 2 {
                                    position = getTopTrailingFrom(containingFrameMaxX: proxy.frame(in: .global).maxX)
                                } else {
                                    position = Self.topLeading
                                }
                            }
                        }
                    )
            )
        }
        .padding()
        .padding(.trailing)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct PostPictureOverlay_Previews: PreviewProvider {
    private var backImage: some View {
        PostImage(imageURL: URL(string: "https://i2.wp.com/anniewearsit.com/wp-content/uploads/2018/03/GOPR0040.jpg?w=4476&h=3357&ssl=1")!)
    }

    private var frontImage: some View {
        PostImage(imageURL: URL(string: "https://i.pinimg.com/736x/83/c4/c5/83c4c56061a4360654977e33b87b2013.jpg")!)
    }

    static var previews: some View {
        PostPictureOverlay(swapped: .constant(false), hideOverlay: false, backImage: PostImage(imageURL: URL(string: "https://i2.wp.com/anniewearsit.com/wp-content/uploads/2018/03/GOPR0040.jpg?w=4476&h=3357&ssl=1")!), frontImage: PostImage(imageURL: URL(string: "https://i.pinimg.com/736x/83/c4/c5/83c4c56061a4360654977e33b87b2013.jpg")!))
    }
}
