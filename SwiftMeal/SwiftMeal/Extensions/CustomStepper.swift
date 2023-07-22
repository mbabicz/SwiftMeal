//
//  CustomStepper.swift
//  SwiftMeal
//
//  Created by kz on 15/04/2023.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var stepperValue: Int {
        didSet {
            if stepperValue < 0 {
                stepperValue = 0
            } else if stepperValue > 25 {
                stepperValue = 25
            }
        }
    }

    
    var body: some View {
        HStack{
            HStack(spacing: 8) {
                Button(action: {
                    stepperValue -= 1
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(.black)
                }
                Divider()
                    .frame(height: 16)
                    .padding(.horizontal, 10)
                
                Button(action: {
                    stepperValue += 1
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            
            .background(Color.gray.opacity(0.16))
            .cornerRadius(10)
        }
    }
}

