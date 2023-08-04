//
//  LoadingView.swift
//  SwiftMealDelivery
//
//  Created by kz on 20/04/2023.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Image("burger")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .padding(20)
            VStack{
                HStack(spacing: 0) {
                    ForEach(Array("SwiftMeal"), id: \.self) { char in
                        Text(String(char))
                            .font(.custom("HelveticaNeue-Bold", size: 40))
                            .fontWeight(.bold)
                            .padding(3)
                            .foregroundColor(.orange)
                            .scaleEffect(isAnimating ? 1.5 : 1.0)
                            .animation(Animation.interpolatingSpring(stiffness: 200, damping: 8).repeatForever(autoreverses: true).delay(Double("SwiftMeal".distance(from: "SwiftMeal".startIndex, to: "SwiftMeal".firstIndex(of: char)!)) / 10))
                            .onAppear() {
                                isAnimating = true
                            }
                    }
                }
                Text("Delivery")
                    .frame(alignment: .trailing)
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
