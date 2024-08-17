//
//  MainBannerView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SwiftUI

struct MainBannerView: View {
    
    let imageLink: String
    let title: String
    let caption: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: imageLink)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 160)
                        .clipped()
                    
                } placeholder: {
                    PlaceholderImageView()
                        .frame(height: 160)
                }
            } else {
                Text("Shaft: Unavailable on iOS 13")
            }
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                    Text(caption)
                        .font(.system(size: 12))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                }
                .padding(.leading, 20)
        }
    }
}

#Preview("Image 0") {
    MainBannerView(imageLink: "https://cms.santander.com.br/sites/MOB_Propostas/imagemproposta/campo-boxer-cmc/24-08-13_193036_M_banner_lp_pre_venda_shows_c+c_v2.jpg", title: "Learning that fits", caption: "Skilss for your present and future")
}
#Preview("Image 1") {
    MainBannerView(imageLink: "https://cms.santander.com.br/sites/MOB_Propostas/imagemproposta/campo-boxer-cmc/24-08-13_193036_M_banner_lp_pre_venda_shows_c+c_v2.jpg", title: "Learning that fits", caption: "Skilss for your present and future")
}
#Preview("Image 2") {
    MainBannerView(imageLink: "https://cms.santander.com.br/sites/MOB_Propostas/imagemproposta/campo-boxer-cmc/24-08-13_193036_P_banner_lp_aproveite_beneficios_c+c_desktop_v2.jpg", title: "Learning that fits", caption: "Skilss for your present and future")
}
#Preview("Image 3") {
    MainBannerView(imageLink: "https://cms.santander.com.br/sites/WPS/imagem/imagem-nova-loja-cartao-smiles-gold/21-06-16_162806_P_smiles_gold_vs.png", title: "Learning that fits", caption: "Skilss for your present and future")
}
#Preview("Image 4") {
    MainBannerView(imageLink: "https://cms.santander.com.br/sites/WPS/imagem/img-cartao-quartz-aa/22-09-16_181507_P_cartao-quartz-aa.png", title: "Learning that fits", caption: "Skilss for your present and future")
}
#Preview("Image 5") {
    MainBannerView(imageLink: "https://cms.santander.com.br/sites/WPS/imagem/imagem-nova-loja-cartao-unique-black/23-12-20_190828_P_unique.png", title: "Learning that fits", caption: "Skilss for your present and future")
}
