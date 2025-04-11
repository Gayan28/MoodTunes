//
//  SongListView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-11.
//

import SwiftUI

struct SongListView: View {
    var title: String
    var subtitle: String
    var backgroundImage: String
    var songs: [Song]

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    Image(backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .overlay(Color.black.opacity(0.3))
                        .cornerRadius(20)
                        .padding()

                    VStack(alignment: .leading, spacing: 10) {
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text(subtitle)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 50)

                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                            Button(action: {}) {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding(.bottom, 50)
                        .padding(.trailing, 40)
                    }
                }

                List {
                    ForEach(songs) { song in
                        HStack {
                            Image(song.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)

                            VStack(alignment: .leading) {
                                Text(song.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text(song.artist)
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            Spacer()
                            if let duration = song.duration {
                                Text(duration)
                                    .foregroundColor(.gray)
                            }
                        }
                        .listRowBackground(Color.black)
                        .padding(.vertical, 5)
                    }
                }
                .background(Color.black)
                .listStyle(PlainListStyle())
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}
