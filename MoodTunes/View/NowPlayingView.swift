//
//  NowPlaying.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct NowPlayingView: View {
    var body: some View {
        ZStack {
            
            Text("Now Playing")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
