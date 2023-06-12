//
//  PostView.swift
//  VeReal
//
//  Created by Théo Pomies on 6/11/23.
//

import SwiftUI

struct PostView: View {
    @State private var isHovered = false
    var body: some View {
        VStack {
            PostHeader()

            PostContent(isHovered: $isHovered)

            PostFooter()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
            .background(.black)
            .foregroundColor(.white)
    }
}
