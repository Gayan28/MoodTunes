//
//  HomeView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: TabItem = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .home:
                DashboardView(selectedTab: $selectedTab)
            case .moods:
                MoodSelectionView()
            case .map:
                MapView()
            case .playing:
                NowPlayingView()
            case .settings:
                SettingsView()
            }

            // Full width tab bar
            CustomTabBar(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.8))
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct DashboardView: View {
    @Binding var selectedTab: TabItem

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            // Greeting
            Text("Hello Gayan,")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)

            Text("How Was Your Day?")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)

            // Daily Mood Card
            HStack {
                Spacer()
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue)
                        .frame(width: 350, height: 410)
                        .overlay(
                            Image("dashboard1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 350, height: 410)
                                .clipped()
                                .cornerRadius(12)
                        )
                }
                Spacer()
            }
            .padding(.vertical)

            Spacer().frame(height: 20)

            // Music Categories Section with images
            HStack(spacing: 20) {
                NavigationLink(destination: FavouritesView()) {
                    CategoryCard(title: "Favourites", imageName: "Image 1")
                }
                NavigationLink(destination: PlaylistsView()) {
                    CategoryCard(title: "Playlists", imageName: "Image 2")
                }
                NavigationLink(destination: RecentsView()) {
                    CategoryCard(title: "Recents", imageName: "Image 3")
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 30)

            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 15/255, green: 8/255, blue: 23/255))
    }
}

struct CategoryCard: View {
    var title: String
    var imageName: String

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 100)
                .clipped()
                .cornerRadius(10)

            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 110, height: 100, alignment: .bottom)
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
        }
        .frame(width: 110, height: 100)
        .cornerRadius(10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// Color Extension (kept for future use if needed)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1.0
        )
    }
}
