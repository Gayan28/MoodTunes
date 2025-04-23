//
//  MoodSelectionView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct MoodSelectionView: View {
    @EnvironmentObject var theme: ThemeManager
    @State private var isNavigatingToDetector = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Spacer().frame(height: 40)

                // Heading
                VStack(alignment: .leading, spacing: 6) {
                    Text("Choose Your Mood")
                        .font(.largeTitle.bold())
                        .foregroundColor(theme.textPrimary)

                    Text("What is your mood today?")
                        .font(.title3)
                        .foregroundColor(.gray)
                }

                // Mood Options
                LazyVGrid(columns: columns, spacing: 20) {
                    MoodItem(imageName: "happymood", title: "Happy")
                    MoodItem(imageName: "angrymood", title: "Angry")
                    MoodItem(imageName: "sadmood", title: "Sad")
                    MoodItem(imageName: "relaxmood", title: "Relax")
                }

                // Auto-Detect Button
                NavigationLink(destination: MoodDetectorView(), isActive: $isNavigatingToDetector) {
                    Button(action: {
                        isNavigatingToDetector = true
                    }) {
                        Text("Auto - Detect")
                            .font(.system(size: 18, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                }
                .padding(.top, 32)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .background(theme.background)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Mood Item
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
                .cornerRadius(14)

            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
        }
    }
}

// MARK: - Preview
struct MoodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MoodSelectionView()
            .environmentObject(ThemeManager())
    }
}
