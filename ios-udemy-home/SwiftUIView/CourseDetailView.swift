//
//  CourseDetailView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SwiftUI

struct CourseDetailView: View {
    let title: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .padding(.bottom, 4)
                
                Text("This is the things you have to do to master in your career")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 24)
                
                Text("""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet et dolor id dictum. Nunc lacinia orci eget mauris laoreet interdum. Donec vestibulum, lorem vitae convallis congue, ex nunc varius nibh, id tempor nisi neque eget lacus. Praesent aliquet, metus imperdiet mattis sodales, sapien urna gravida tellus, eu ultrices purus metus sit amet mi. Phasellus facilisis consectetur ante eget ornare. Etiam elementum egestas tortor, feugiat lobortis ante blandit eu. Sed bibendum ipsum a eros volutpat, id iaculis nibh cursus. Sed sit amet sapien in urna aliquam molestie.
"""
                )
                
                Spacer()
                Spacer()
            }
            .padding(24)
        }
    }
}

#Preview {
    CourseDetailView(title: "How to become a Senior iOS Engineer")
}
