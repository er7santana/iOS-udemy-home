//
//  PlaceholderImageView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SwiftUI

struct PlaceholderImageView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.gray.opacity(0.3))
    }
}

#Preview {
    PlaceholderImageView()
}
