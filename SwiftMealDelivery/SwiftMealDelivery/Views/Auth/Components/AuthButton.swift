//
//  AuthButton.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 06/08/2023.
//

import SwiftUI

struct AuthButton: View {
    let imageName: String
    let text: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                Text(text)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: 0.5))
        }
    }
}

struct AuthButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthButton(imageName: "google_logo", text: "Continue with Google", backgroundColor: .gray.opacity(0.2), action: {})
    }
}
