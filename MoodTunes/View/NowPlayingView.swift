//  NowPlayingView 2.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-11.
//

import SwiftUI

struct NowPlayingView: View {
    var body: some View {
        VStack(spacing: 30) {
            
            // Playlist header
            Text("PLAYING FROM PLAYLIST")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.bottom, 10)
            
            // Image of the song being played
            Image("playingImg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 320, height: 320)
                .cornerRadius(12)
            
            // Song title
            Text("Naiyo Lagda")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.semibold)
            
            // Artist name
            Text("Arijit Singh")
                .foregroundColor(.gray)
                .font(.subheadline)
            
            // Progress bar section
            VStack(spacing: 4) {
                Slider(value: .constant(0.01), in: 0...1)
                    .accentColor(.white)
                    .padding(.horizontal, 30)
                
                // Time labels (start and end)
                HStack {
                    Text("0:03")
                    Spacer()
                    Text("3:53")
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
            }
            
            // Player controls (icons for shuffle, backward, pause, forward, and heart)
            HStack(spacing: 40) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                Image(systemName: "backward.fill")
                    .font(.system(size: 24))
                Image(systemName: "pause.circle.fill")
                    .font(.system(size: 50))
                Image(systemName: "forward.fill")
                    .font(.system(size: 24))
                Image(systemName: "heart")
                    .font(.system(size: 24))
            }
            .foregroundColor(.white)
            .padding(.top, 10)
            
            Spacer()
            
            // Additional footer text (could be used for showing music-related info)
            Text("Enjoy your music!")
                .foregroundColor(.white)
                .font(.caption)
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(12)
        }
        .padding(.top, 40)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.black]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        )
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
