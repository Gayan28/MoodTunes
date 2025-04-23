//
//  MoodDetectorView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct MoodDetectorView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                // Header
                VStack(alignment: .leading, spacing: 6) {
                    Text("Mood Detector")
                        .font(.largeTitle.bold())
                        .foregroundColor(theme.textPrimary)

                    Text("Let's check your mood!")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)

                // Camera Placeholder / Future Live Camera Feed
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.6))
                    .frame(width: 340, height: 400)
                    .overlay(
                        VStack {
                            Image(systemName: "camera.viewfinder")
                                .font(.system(size: 40))
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.bottom, 10)

                            Text("Camera View")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                        }
                    )

                // Instruction Text
                Text("Show your face to the camera to detect your mood")
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()
            }
            .padding(.top)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(theme.background)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview
struct MoodDetectorView_Previews: PreviewProvider {
    static var previews: some View {
        MoodDetectorView()
            .environmentObject(ThemeManager())
    }
}
