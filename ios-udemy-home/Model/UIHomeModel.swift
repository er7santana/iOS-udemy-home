//
//  UIHomeModel.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import Foundation

struct HomeUIModel: Hashable {
    
    let sectionModels: [SectionModel]
    
    struct SectionModel: Hashable {
        let section: Section
        let body: [Item]
    }
    
    enum Section: Hashable {
        case mainBanner(id: String)
        case textHeader(id: String)
        case courseSwimLane(id: String)
        case udemyBusinessBanner(id: String)
        case categories(id: String)
        case featureCourse(id: String)
    }
    
    enum Item: Hashable {
        case mainBanner(id: String, imageLink: String, title: String, caption: String)
        case course(id: String, imageLink: String, title: String, author: String, rating: Double, reviewCount: Int, price: Decimal, tag: String)
        case textHeader(id: String, text: String, highlightedText: String?)
        case udemyBusinessBanner(id: String, link: String)
        case categoriesScroller(id: String, titles: [String])
        case featureCourse(id: String, imageLink: String, title: String, author: String, rating: Double, reviewCount: Int, price: Decimal)
    }
}
