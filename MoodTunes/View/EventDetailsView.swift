//
//  EventDetailsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import SwiftUI

struct EventDetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Title
            Text("Concert Details")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            // Poster - Centered
            HStack {
                Spacer()
                Image("concert")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(width: 300) 
                Spacer()
            }
            
            // Concert Info
            VStack(alignment: .leading, spacing: 8) {
                Text("Aluth Kalawak")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Text("Classical Fusion & Sri Lankan Folk")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            
            // Date & Venue
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date and Time")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("July 20, 2024 | 7:00 PM")
                        .foregroundColor(.white)
                        .font(.body)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Venue")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Nelum Pokuna Theatre")
                        .foregroundColor(.white)
                        .font(.body)
                }
            }
            
            // Description
            VStack(alignment: .leading, spacing: 8) {
                Text("About the Concert")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("""
Aluth Kalawak is a celebration of Sri Lankan heritage with a modern twist. Featuring top Sri Lankan artists, this fusion concert brings together classical rhythms and folk traditions with vibrant, contemporary performances. Experience a night of cultural pride, music, dance, and unity.
""")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Directions Button
            Button(action: {
                // Navigation logic here
            }) {
                Text("Directions")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .toolbar(.hidden, for: .tabBar)
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView()
    }
}
