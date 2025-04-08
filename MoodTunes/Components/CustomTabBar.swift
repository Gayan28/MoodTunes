import SwiftUI

enum TabItem: Int {
    case home, moods, map, playing, settings
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabItem

    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(icon: "house.fill", title: "Home", tab: .home, selectedTab: $selectedTab)
            TabBarButton(icon: "music.note.list", title: "Moods", tab: .moods, selectedTab: $selectedTab)
            TabBarButton(icon: "map", title: "Map", tab: .map, selectedTab: $selectedTab)
            TabBarButton(icon: "play.circle", title: "Playing", tab: .playing, selectedTab: $selectedTab)
            TabBarButton(icon: "gearshape", title: "Settings", tab: .settings, selectedTab: $selectedTab)
        }
        .padding(.top, 10)
        .frame(height: 70)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.8))
        .cornerRadius(0) 
    }
}

struct TabBarButton: View {
    var icon: String
    var title: String
    var tab: TabItem
    @Binding var selectedTab: TabItem

    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(selectedTab == tab ? .blue : .gray)
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(selectedTab == tab ? .blue : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
