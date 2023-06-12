//
//  PostFeed.swift
//  VeReal
//
//  Created by Théo Pomies on 6/11/23.
//

import SwiftUI

struct PostFeed: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0 ..< 20) { _ in
                    PostView()
                }
            }
        }
    }
}

struct PostFeed_Previews: PreviewProvider {
    static var previews: some View {
        PostFeed()
            .background(.black)
            .foregroundColor(.white)
    }
}
