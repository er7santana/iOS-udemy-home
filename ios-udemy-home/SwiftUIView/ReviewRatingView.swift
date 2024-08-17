//
//  ReviewRatingView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SwiftUI

struct ReviewRatingView: View {
    
    let rating: Double
    let reviewCount: Int
    
    var body: some View {
        HStack(spacing: 4) {
            Text(rating.description)
                .foregroundColor(.orange)
                .font(.system(size: 10, weight: .semibold))
            
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.yellow)
                .frame(height: 10)
            
            Text(reviewCount.description.withBrackets)
                .foregroundColor(.secondary)
                .font(.system(size: 10))
            
            
        }
    }
}

#Preview {
    ReviewRatingView(rating: 4.5, reviewCount: 4226)
}
