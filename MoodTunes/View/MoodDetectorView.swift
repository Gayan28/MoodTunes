//
//  MoodDetectorView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-03.
//

import SwiftUI

struct MoodDetectorView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                // Header
                VStack(alignment: .leading, spacing: 6) {
                    Text("Mood Detector")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)

                    Text("Let's check your mood!")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)

                // Camera Placeholder
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.6))
                    .frame(width: 350, height: 400)
                    .overlay(
                        Text("Camera View")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    )

                // Bottom Message
                Text("Show your face to the camera to detect your mood")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()
            }
            .padding(.top)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "0F0817"))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview
struct MoodDetectorView_Previews: PreviewProvider {
    static var previews: some View {
        MoodDetectorView()
    }
}
