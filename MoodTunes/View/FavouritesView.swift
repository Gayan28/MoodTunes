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
        Song(title: "You Right", artist: "Doja Cat, The Weeknd", imageName: "song1", duration: "3:20"),
        Song(title: "2 AM", artist: "Arizona Zervas", imageName: "song2", duration: "2:45"),
        Song(title: "Baddest", artist: "2 Chainz, Chris Brown", imageName: "song3", duration: "3:10"),
        Song(title: "True Love", artist: "Kanye West", imageName: "song4", duration: "2:58"),
        Song(title: "Bye Bye", artist: "Marshmello, Juice WRLD", imageName: "song5", duration: "3:05"),
        Song(title: "Hands on You", artist: "Austin George", imageName: "song6", duration: "3:56"),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Image
            ZStack(alignment: .bottomLeading) {
                Image("favouriteImg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 260)
                    .clipped()
                
                LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .frame(height: 260)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Favourites")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("All your favourite songs")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
            }

            // Songs List
            ScrollView {
                VStack(spacing: 18) {
                    ForEach(songs) { song in
                        HStack(spacing: 12) {
                            Image(song.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(song.title)
                                    .font(.headline)
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
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .toolbar(.hidden, for: .tabBar)
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
