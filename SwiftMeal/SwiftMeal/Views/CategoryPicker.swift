//
//  CategoryPicker.swift
//  SwiftMeal
//
//  Created by mbabicz on 04/07/2023.
//

import SwiftUI

struct CategoryPicker: View {
    
    @Binding var selectedCategory: Category
    
    var body: some View {
        Picker(selection: $selectedCategory, label: Text("Select a category")) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.rawValue)
                    .bold()
                    .tag(category)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(.white)
        .cornerRadius(8)
        .padding([.horizontal, .top])
    }
}

