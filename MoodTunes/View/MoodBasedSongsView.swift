//
//  MoodBasedSongsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-11.
//

import SwiftUI

struct MoodBasedSongsView: View {
    var mood: String
    @State private var songs: [Song] = []

    var backgroundImage: String {
        switch mood.lowercased() {
        case "happy": return "img3"
        case "sad": return "img4"
        case "chill": return "img5"
        default: return "img3"
        }
    }

    var title: String {
        switch mood.lowercased() {
        case "happy": return "Happy Songs"
        case "sad": return "Sad Vibes"
        case "chill": return "Chill Beats"
        default: return "Mood Songs"
        }
    }

    var subtitle: String {
        switch mood.lowercased() {
        case "happy": return "Chill your mind"
        case "sad": return "Feel the moment"
        case "chill": return "Relax and unwind"
        default: return "Handpicked for your mood"
        }
    }

    var body: some View {
        SongListView(
            title: title,
            subtitle: subtitle,
            backgroundImage: backgroundImage,
            songs: songs
        )
        .onAppear {
            loadSongsForMood(mood)
        }
    }

    func loadSongsForMood(_ mood: String) {
        // Replace this mock logic with API calls
        self.songs = [
            Song(title: "You right", artist: "Doja Cat", imageName: "song1", duration: nil),
            Song(title: "2 AM", artist: "Arizona Zervas", imageName: "song2", duration: nil)
        ]
    }
}
