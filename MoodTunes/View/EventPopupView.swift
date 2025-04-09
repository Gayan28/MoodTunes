//
//  EventPopupView.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-09.
//

import SwiftUI

struct EventPopupView: View {
    let event: Event
    let onTapDetails: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: event.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(height: 100)
            .cornerRadius(10)

            Text("More Details")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.blue)
                .onTapGesture {
                    onTapDetails()
                }
            
            Text(event.name)
                .font(.subheadline)
                .fontWeight(.semibold)

        }
        .padding()
        .background(Color(.systemBackground).opacity(0.95))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
