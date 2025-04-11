//
//  NowPlayingView 2.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-11.
//


import SwiftUI

struct NowPlayingView: View {
    var body: some View {
        VStack(spacing: 30) {
            
            Text("PLAYING FROM PLAYLIST")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.bottom, 10)
            
            Image("playingImg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 320, height: 320)
                .cornerRadius(12)
            
            Text("Naiyo Lagda")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Arijit Singh")
                .foregroundColor(.gray)
                .font(.subheadline)
            
            // Progress bar
            VStack(spacing: 4) {
                Slider(value: .constant(0.01), in: 0...1)
                    .accentColor(.white)
                    .padding(.horizontal, 30)
                
                HStack {
                    Text("0:03")
                    Spacer()
                    Text("3:53")
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
            }
            
            // Player controls
            HStack(spacing: 40) {
                Image(systemName: "shuffle")
                Image(systemName: "backward.fill")
                Image(systemName: "pause.circle.fill")
                    .font(.system(size: 50))
                Image(systemName: "forward.fill")
                Image(systemName: "heart")
            }
            .foregroundColor(.white)
            .padding(.top, 10)
            
            Spacer()
            
    
            .foregroundColor(.white)
            .font(.caption)
            .padding()
            .background(Color.black.opacity(0.3))
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
