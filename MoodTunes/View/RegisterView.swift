//
//  RegisterScreen.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI

struct RegisterView: View {
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isRegisterSelected = true
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            
            // Logo
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 202, height: 138)
            
            // App Name
            Text("MOODTUNES")
                .font(.custom("Times New Roman", size: 24))
                .foregroundColor(.black)
                .kerning(2)
            
            // Register/Login Toggle
            HStack(spacing: 0) {
                Button(action: {
                    isRegisterSelected = true
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(isRegisterSelected ? Color.white : Color.clear)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(isRegisterSelected ? Color.black : Color.clear, lineWidth: 1)
                        )
                }
                
                Button(action: {
                    isRegisterSelected = false
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(!isRegisterSelected ? Color.white : Color.clear)
                        .cornerRadius(5)
                }
            }
            .frame(height: 40)
            .frame(maxWidth: 250)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.vertical, 20)
            
            // Input Fields
            Group {
                CustomTextField(placeholder: "User Name", text: $userName)
                CustomTextField(placeholder: "Email", text: $email)
                SecureTextField(placeholder: "Password", text: $password)
                SecureTextField(placeholder: "Conform Password", text: $confirmPassword)
            }
            
            // Sign Up Button
            Button(action: {
                // Sign Up action
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.horizontal, 30)
            
            // Conditions Text
            HStack {
                Text("By signing up, you accept our")
                    .foregroundColor(.black.opacity(0.7))
                Text("conditions")
                    .foregroundColor(.blue)
            }
            .padding(.top, 10)
            
            // Login Redirect
            HStack {
                Text("Have an account?")
                    .foregroundColor(.black.opacity(0.7))
                Text("Login")
                    .foregroundColor(.blue)
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
