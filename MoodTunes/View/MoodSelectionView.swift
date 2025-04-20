//
//  MoodSelectionView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct MoodSelectionView: View {
    @State private var isNavigatingToDetector = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Spacer().frame(height: 40)

                Text("Choose Your Mood")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)

                Text("What is your mood today?")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)

                LazyVGrid(columns: columns, spacing: 16) {
                    MoodItem(imageName: "happymood", title: "Happy")
                    MoodItem(imageName: "angrymood", title: "Angry")
                    MoodItem(imageName: "sadmood", title: "Sad")
                    MoodItem(imageName: "relaxmood", title: "Relax")
                }

                NavigationLink(destination: MoodDetectorView(), isActive: $isNavigatingToDetector) {
                    Button(action: {
                        isNavigatingToDetector = true
                    }) {
                        Text("Auto - Detect")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.top, 40)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .background(Color(hex: "#0F0817"))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
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
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
        }
    }
}

struct MoodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MoodSelectionView()
    }
}
