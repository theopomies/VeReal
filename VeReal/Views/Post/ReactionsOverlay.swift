//
//  ReactionsOverlay.swift
//  VeReal
//
//  Created by Théo Pomies on 6/12/23.
//

import SwiftUI

struct ReactionsOverlay: View {
    @Environment(\.colorScheme) var colorScheme

    var isVisible: Bool

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bubble.left.fill")
            Image(systemName: colorScheme == .light ? "smiley.fill" : "smiley")
                .onTapGesture {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
        }
        .shadow(radius: 5)
        .font(.title2)
        .opacity(isVisible ? 0.95 : 0)
        .padding()
    }
}

struct ReactionsOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ReactionsOverlay(isVisible: true)
    }
}
