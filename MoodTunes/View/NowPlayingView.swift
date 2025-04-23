//  NowPlayingView 2.swift
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
                ControlButton(systemName: "shuffle")
                ControlButton(systemName: "backward.fill")

                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 50))
                }

                ControlButton(systemName: "forward.fill")

                Button(action: {
                    isFavorite.toggle()
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

    // MARK: - Helpers

    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

struct ControlButton: View {
    let systemName: String

    var body: some View {
        Button {
            // You can later link this to audio control actions
        } label: {
            Image(systemName: systemName)
                .font(.system(size: 24))
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
