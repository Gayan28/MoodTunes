//
//  SplashScreen.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Logo
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 330, height: 270)
            
            // Tagline
            Text("MoodTunes – Let Your Emotions Play")
                .font(.system(size: 26, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            
            // Description 
            HStack(alignment: .top, spacing: 5) {
                Text("🎵")
                    .font(.system(size: 20))
                Text("Personalized music based on your mood and activity. Relax, energize, or focus with the perfect soundtrack—automatically curated for you!")
                    .italic()
            }
            .font(.system(size: 18, weight: .regular))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .padding(.horizontal, 30)
            
            Spacer()
            
            // Buttons with spacing
            VStack(spacing: 30) {
                Button(action: {
                    // Sign In action
                }) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                
                Button(action: {
                    // Sign Up action
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
