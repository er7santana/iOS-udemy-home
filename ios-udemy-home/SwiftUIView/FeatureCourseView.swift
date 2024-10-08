//
//  FeatureCourseView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SwiftUI

struct FeatureCourseView: View {
    let imageLink: String
    let title: String
    let author: String
    let rating: Double
    let reviewCount: Int
    let price: Decimal
    
    var onTap: CustomHandler?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: imageLink)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                        .border(Color.gray.opacity(0.3))
                        .clipped()
                } placeholder: {
                    PlaceholderImageView()
                        .frame(height: 140)
                }
                .padding(.bottom, 4)
            } else {
                Text("Shaft: Unavailable on iOS 13")
            }
            
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(4)
            
            Text(author)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.secondary)
            
            ReviewRatingView(rating: rating, reviewCount: reviewCount)
            
            Text(price.priceFormat)
                .font(.system(size: 10, weight: .bold))
        }
        .onTapGesture {
            onTap?()
        }
    }
}

#Preview {
    FeatureCourseView(
        imageLink: "https://cms.santander.com.br/sites/MOB_Propostas/imagemproposta/campo-boxer-cmc/24-08-13_193036_P_banner_lp_aproveite_beneficios_c+c_desktop_v2.jpg",
        title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
        author: "Kevin Fok",
        rating: 4.5,
        reviewCount: 224,
        price: 19.99
    )
}
