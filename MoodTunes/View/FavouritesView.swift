//
//  FavouritesView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct Song: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let imageName: String
    let duration: String?
}

struct FavouritesView: View {
    
    let songs: [Song] = [
        Song(title: "You right", artist: "Doja Cat, The Weeknd", imageName: "song1", duration: nil),
        Song(title: "2 AM", artist: "Arizona Zervas", imageName: "song2", duration: nil),
        Song(title: "Baddest", artist: "2 Chainz, Chris Brown", imageName: "song3", duration: nil),
        Song(title: "True Love", artist: "Kanye West", imageName: "song4", duration: nil),
        Song(title: "Bye Bye", artist: "Marshmello, Juice WRLD", imageName: "song5", duration: nil),
        Song(title: "Hands on you", artist: "Austin George", imageName: "song6", duration: "3:56"),
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Full Cover Header
            ZStack(alignment: .bottomLeading) {
                Image("favouriteImg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 260)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Favourites")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("All Favourite songs!")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
            }
            
            // Song List
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(songs) { song in
                        HStack {
                            Image(song.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading) {
                                Text(song.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text(song.artist)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if let duration = song.duration {
                                Text(duration)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
