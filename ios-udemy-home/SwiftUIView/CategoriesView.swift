//
//  CategoriesView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SwiftUI

struct CategoriesView: View {
    
    let titles: [String]
    
    var midPoint: Int {
        return Int(titles.count / 2)
    }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 8) {
                HStack {
                    ForEach(titles[..<midPoint], id: \.self) { title in
                        CategoryButton(title: title)
                    }
                }
                HStack {
                    ForEach(titles[midPoint...], id: \.self) { title in
                        CategoryButton(title: title)
                    }
                }
            }
        }
    }
}

struct CategoryButton: View {
    
    let title: String
    var onTap: (() -> Void)?
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            Text(title)
                .padding(12)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(.black, lineWidth: 1.0))
        }
    }
}

#Preview {
    CategoriesView(titles: Category.allCases.map { $0.rawValue.camelCaseToEnglish.useShortAndFormat })
}
