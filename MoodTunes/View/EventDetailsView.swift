//
//  EventDetailsView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import SwiftUI

struct EventDetailsView: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Concert Details")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.top, 20)

            HStack {
                Spacer()
                Image(event.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(width: 300)
                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(event.name)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Text(event.genre)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date and Time")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(event.date)
                        .foregroundColor(.white)
                        .font(.body)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Venue")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(event.venue)
                        .foregroundColor(.white)
                        .font(.body)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("About the Concert")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(event.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: {
                // Navigate to directions
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
