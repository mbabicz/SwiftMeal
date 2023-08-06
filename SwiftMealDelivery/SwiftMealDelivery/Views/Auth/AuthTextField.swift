//
//  AuthTextField.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 06/08/2023.
//

import SwiftUI

struct AuthTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
    }
}

struct AuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        AuthTextField(placeholder: "Email", text: .constant(""))
    }
}
