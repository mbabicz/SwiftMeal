//
//  LocationZipView.swift
//  SwiftMeal
//
//  Created by mbabicz on 04/07/2023.
//

import SwiftUI

struct LocationZipView: View {
    
    @State var zip = ""
    var body: some View {
        
        TextField("ZIP CODE", text: $zip)
            .foregroundColor(zip == "" ? .gray : .black)
            .padding(.leading, 5)
            .background(Color.white)
            .background(Color(.white))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.gray), lineWidth: 0.5))
            .padding(.horizontal)
        
    }
}

struct LocationZipView_Previews: PreviewProvider {
    static var previews: some View {
        LocationZipView()
    }
}
