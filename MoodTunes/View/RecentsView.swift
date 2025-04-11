//
//  RecentsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct RecentsView: View {
    let songs: [Song] = [/* your recent songs here */]

    var body: some View {
        SongListView(
            title: "Recents",
            subtitle: "All Recent played songs!",
            backgroundImage: "RecentsImg",
            songs: songs
        )
    }
}
