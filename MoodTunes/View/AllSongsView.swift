//
//  AllSongsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct AllSongsView: View {
    let categories = [
        ("Happy Songs", "bg1"),
        ("Sad Songs", "bg2"),
        ("Angry Songs", "bg3"),
        ("Relax Songs", "bg4")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Let’s Discover")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("your next song to play!")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("All Categories")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 25) {
                ForEach(categories, id: \.0) { category in
                    VStack {
                        Image(category.1)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                        
                        Text(category.0)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                    }
                }
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct AllSongsView_Previews: PreviewProvider {
    static var previews: some View {
        AllSongsView()
    }
}
