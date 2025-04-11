//
//  CategoryCard.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-10.
//

import SwiftUI

struct CategoryCard2: View {
    let imageURL: String
    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: 120, height: 160)
            .cornerRadius(12)

            Text(title)
                .font(.caption)
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .frame(width: 120)
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard2(imageURL: "https://example.com/image.jpg", title: "Concert")
            .background(Color.black)
    }
}
