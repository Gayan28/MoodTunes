//
//  VerificationScreen.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-04.
//

import SwiftUI

struct VerificationScreen: View {
    @State private var otp1 = ""
    @State private var otp2 = ""
    @State private var otp3 = ""
    @State private var otp4 = ""
    @State private var navigateToHome = false // 1. Add this state
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 50)

                // Logo
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 235, height: 230)

                // Instruction Text
                Text("We have sent a one-time password (OTP) to your\nregistered mobile number")
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)

                // OTP Input Fields
                HStack(spacing: 15) {
                    OTPTextField(text: $otp1)
                    OTPTextField(text: $otp2)
                    OTPTextField(text: $otp3)
                    OTPTextField(text: $otp4)
                }
                .padding(.top, 20)

                // Resend OTP Link
                HStack {
                    Text("Didn’t Receive?")
                        .foregroundColor(Color.gray)
                    Button(action: {
                        // Resend OTP Action
                    }) {
                        Text("Resend OTP")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 10)

                // Verify Button
                Button(action: {
                    // Here you would verify the OTP, and then:
                    navigateToHome = true
                }) {
                    Text("VERIFY")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .padding(.top, 20)
                .padding(.horizontal, 30)

                // NavigationLink to HomeView
                NavigationLink(
                    destination: HomeView()
                        .navigationBarBackButtonHidden(true) 
                        .navigationBarHidden(true),
                    isActive: $navigateToHome
                ) {
                    EmptyView()
                }

                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

// OTP TextField View
struct OTPTextField: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .frame(width: 50, height: 50)
            .multilineTextAlignment(.center)
            .font(.system(size: 22, weight: .bold))
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .keyboardType(.numberPad)
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationScreen()
    }
}
