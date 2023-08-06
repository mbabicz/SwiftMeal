//
//  LogoView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 06/08/2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack {
            Image("burger")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 65, height: 65)
            VStack(alignment: .leading) {
                Text("SwiftMeal")
                    .font(.custom("HelveticaNeue-Bold", size: 45))
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                Text("Delivery")
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                    .foregroundColor(.gray)
            }
        }    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
