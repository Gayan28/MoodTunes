//
//  SplashScreen.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Logo
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330, height: 270)
                
                // Tagline
                Text("MoodTunes – Let Your Emotions Play")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .dynamicTypeSize(.xSmall ... .accessibility3)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 20)
                
                // Description
                HStack(alignment: .top, spacing: 5) {
                    Text("🎵")
                        .font(.title3)
                    
                    Text("Personalized music based on your mood and activity. Relax, energize, or focus with the perfect soundtrack—automatically curated for you!")
                        .font(.body)
                        .italic()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .dynamicTypeSize(.xSmall ... .accessibility3)
                        .minimumScaleFactor(0.8)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 30) {
                    NavigationLink(destination: AuthView()) {
                        Text("Sign In")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .dynamicTypeSize(.xSmall ... .accessibility3)
                            .minimumScaleFactor(0.8)
                    }
                    .padding(.horizontal, 40)
                    
                    NavigationLink(destination: AuthView()) {
                        Text("Sign Up")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .dynamicTypeSize(.xSmall ... .accessibility3)
                            .minimumScaleFactor(0.8)
                    }
                    .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .preferredColorScheme(.dark)
    }
}
