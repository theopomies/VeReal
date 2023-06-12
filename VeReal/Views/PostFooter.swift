//
//  PostFooter.swift
//  VeReal
//
//  Created by Théo Pomies on 6/11/23.
//

import SwiftUI

struct PostFooter: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Tulum ca tue")
                    .font(.headline)
                Text("Add a comment...")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct PostFooter_Previews: PreviewProvider {
    static var previews: some View {
        PostFooter()
    }
}
