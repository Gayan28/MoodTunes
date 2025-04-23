//  RecentsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

// Song model
struct Song1: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let imageName: String
    let duration: String?
}

// Main Recents View
struct RecentsView: View {
    
    let songs: [Song1] = [
        Song1(title: "You Right", artist: "Doja Cat, The Weeknd", imageName: "song1", duration: "3:45"),
        Song1(title: "2 AM", artist: "Arizona Zervas", imageName: "song2", duration: "2:53"),
        Song1(title: "Baddest", artist: "2 Chainz, Chris Brown", imageName: "song3", duration: "3:20"),
        Song1(title: "True Love", artist: "Kanye West", imageName: "song4", duration: "4:10"),
        Song1(title: "Bye Bye", artist: "Marshmello, Juice WRLD", imageName: "song5", duration: "2:45"),
        Song1(title: "Hands On You", artist: "Austin George", imageName: "song6", duration: "3:56"),
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Header Banner
                ZStack(alignment: .bottomLeading) {
                    Image("RecentsImg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 260)
                        .clipped()
                    
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.6)]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                        .frame(height: 260)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recents")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("All recently played songs!")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding()
                }
                
                // Song List
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(songs) { song in
                            NavigationLink(destination: NowPlayingView()) {
                                SongRow(song: song)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

// Reusable Song Row View
struct SongRow: View {
    let song: Song1
    
    var body: some View {
        HStack {
            Image(song.imageName)
                .resizable()
                .frame(width: 50, height: 50)
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
        .padding(.vertical, 8)
    }
}

struct RecentsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentsView()
    }
}
