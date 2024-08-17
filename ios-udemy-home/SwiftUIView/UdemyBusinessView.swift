//
//  UdemyBusinessView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SwiftUI

struct UdemyBusinessView: View {
    var onTap: CustomHandler?
    var body: some View {
        VStack(spacing: 20) {
            Text("Top companies trust Udemy")
                .font(.system(size: 18, weight: .semibold, design: .serif))
                .padding(.top, 16)
            HStack(spacing: 40) {
                UdemyBusinessIconView(systemName: "apple.logo")
                UdemyBusinessIconView(systemName: "shazam.logo.fill")
                UdemyBusinessIconView(systemName: "playstation.logo")
            }
            
            Button(action: {
                onTap?()
            }, label: {
                Text("Try Udemy Business")
                    .font(.system(size: 12, weight: .bold))
            })
            .foregroundColor(Color(UIColor.systemIndigo))
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity)
        .border(Color(UIColor.systemGray))
    }
}

struct UdemyBusinessIconView: View {
    
    let systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 48, height: 48)
            .foregroundColor(Color(UIColor.gray))
    }
}

#Preview {
    UdemyBusinessView()
}
