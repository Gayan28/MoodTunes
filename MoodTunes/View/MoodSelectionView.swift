//
//  MoodSelectionView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct MoodSelectionView: View {
    @Binding var selectedTab: TabItem

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                Spacer().frame(height: 40)

                // Title
                Text("Choose Your Mood")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)

                Text("What is your mood today?")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)

                // Mood Grid
                LazyVGrid(columns: columns, spacing: 16) {
                    MoodItem(imageName: "happymood", title: "Happy")
                    MoodItem(imageName: "angrymood", title: "Angry")
                    MoodItem(imageName: "sadmood", title: "Sad")
                    MoodItem(imageName: "relaxmood", title: "Relax")
                }

                // Auto Detect Button
                Button(action: {
                    // Handle auto-detect mood
                }) {
                    Text("Auto - Detect")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 40)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 90)

            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.9))
                .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color(hex: "#0F0817"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MoodItem: View {
    var imageName: String
    var title: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 185)
                .clipped()
                .cornerRadius(12)

            Text(title)
                .font(.system(size: 20, weight: .semibold)) // ✅ Updated font size
                .foregroundColor(.white)
        }
    }
}

struct MoodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MoodSelectionView(selectedTab: .constant(.moods))
    }
}
