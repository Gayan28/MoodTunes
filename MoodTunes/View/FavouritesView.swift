//
//  FavouritesView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct FavouritesView: View {
    let songs: [Song] = [/* your favourite songs here */]

    var body: some View {
        SongListView(
            title: "Favourites",
            subtitle: "All Favourites songs!",
            backgroundImage: "favouriteImg",
            songs: songs
        )
    }
}


