//
//  CustomeTextFields.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI

// Custom TextField View
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.bottom, 10)
    }
}

// Custom SecureField View with Eye Icon
struct SecureTextField: View {
    var placeholder: String
    @Binding var text: String
    @State private var isSecure = true

    var body: some View {
        HStack {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }

            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye" : "eye.slash")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.bottom, 10)
    }
}
