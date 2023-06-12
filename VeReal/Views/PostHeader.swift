//
//  PostHeader.swift
//  VeReal
//
//  Created by Théo Pomies on 6/11/23.
//

import SwiftUI

struct PostHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .font(.title)
            VStack(alignment: .leading) {
                Text("ririssou")
                    .font(.headline)
                Text("New York, Brooklyn • Yesterday at 9:17:58 PM")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
            Menu {
                Button {} label: {
                    Label("View profile", systemImage: "person.circle")
                }
                Button {} label: {
                    Label("Share profile", systemImage: "square.and.arrow.up")
                }
                Button(role: .destructive) {} label: {
                    Label("Report this BeReal.", systemImage: "exclamationmark.triangle")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.headline)
                    .padding(.vertical)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct PostHeader_Previews: PreviewProvider {
    static var previews: some View {
        PostHeader()
    }
}
