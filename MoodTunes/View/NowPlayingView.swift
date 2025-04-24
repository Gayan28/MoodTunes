//
//  NowPlayingView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-11.
//

import SwiftUI

struct NowPlayingView: View {
    @State private var isPlaying = true
    @State private var isFavorite = false
    @State private var currentTime: Double = 3
    let totalTime: Double = 233 // 3:53 in seconds

    var body: some View {
        VStack(spacing: 30) {

            // Playlist header
            Text("PLAYING FROM PLAYLIST")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.bottom, 10)

            // Album Art
            Image("playingImg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .cornerRadius(16)

            // Song Info
            VStack(spacing: 6) {
                Text("Naiyo Lagda")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Arijit Singh")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }

            // Progress Bar
            VStack(spacing: 4) {
                Slider(value: $currentTime, in: 0...totalTime)
                    .accentColor(.white)
                    .padding(.horizontal, 30)

                HStack {
                    Text(formatTime(currentTime))
                    Spacer()
                    Text(formatTime(totalTime))
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
            }

            // Playback Controls
            HStack(spacing: 40) {
                Button(action: {
                    // Toggle shuffle logic (placeholder)
                    print("Shuffle tapped")
                }) {
                    Image(systemName: "shuffle")
                        .font(.system(size: 24))
                }

                Button(action: {
                    // Simulate previous track logic
                    print("Previous track tapped")
                    currentTime = 0 // Reset to beginning
                }) {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 24))
                }

                Button(action: {
                    isPlaying.toggle()
                    print(isPlaying ? "Playing" : "Paused")
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 50))
                }

                Button(action: {
                    // Simulate next track logic
                    print("Next track tapped")
                    currentTime = 0 // Reset to simulate next
                }) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 24))
                }

                Button(action: {
                    isFavorite.toggle()
                    print(isFavorite ? "Added to favorites" : "Removed from favorites")
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundColor(isFavorite ? .red : .white)
                }
            }
            .foregroundColor(.white)
            .padding(.top, 10)

            Spacer()

            // Footer
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

    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
