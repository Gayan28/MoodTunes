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
        CategoryCard2(imageURL: "https://www.google.com/url?sa=i&url=https%3A%2F%2Flk.bookmyshow.com%2Fyears%2F2023%2Fevents%2F3&psig=AOvVaw14Xh0Jb_oQCRpBsBPfhAAG&ust=1744314174721000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCJCJrOray4wDFQAAAAAdAAAAABAE", title: "Concert")
            .background(Color.black)
    }
}
