//
//  TogglePasswordView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 06/08/2023.
//

import SwiftUI

struct TogglePasswordView: View {
    @Binding var isSecured: Bool
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
    }
}

struct TogglePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        TogglePasswordView(isSecured: .constant(false), placeholder: "Password", text: .constant(""))
    }
}
