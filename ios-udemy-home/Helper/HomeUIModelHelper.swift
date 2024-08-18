//
//  HomeUIModelHelper.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import Foundation

struct HomeUIModelHelper {
    typealias SectionModel = HomeUIModel.SectionModel
    
    private init() { }
    
    static func makeUIModel(response: APIResponse) -> HomeUIModel {
        var sectionModels = [HomeUIModel.SectionModel]()
        for layout in response.layouts {
            switch layout {
            case let .mainBanner(id, mainBanner):
                let sectionModel = SectionModel(
                    section: .mainBanner(id: id),
                    body: [
                        .mainBanner(id: mainBanner.id,
                                    imageLink: mainBanner.imageLink,
                                    title: mainBanner.title,
                                    caption: mainBanner.caption)
                    ]
                )
                sectionModels.append(sectionModel)
            case let .textHeader(id, textHeader):
                let sectionModel = SectionModel(
                    section: .textHeader(id: id),
                    body: [
                        .textHeader(id: textHeader.id,
                                    text: textHeader.text,
                                    highlightedText: textHeader.highlightedText)
                    ]
                )
                sectionModels.append(sectionModel)
            case let .courseSwimlane(id, courses):
                let items: [HomeUIModel.Item] = courses.map { course in
                    return .course(
                        id: course.id,
                        imageLink: course.imageLink,
                        title: course.title,
                        author: course.author,
                        rating: course.rating,
                        reviewCount: course.reviewCount,
                        price: course.price,
                        tag: course.tag
                    )
                }
                let sectionModel = SectionModel(
                    section: .courseSwimLane(id: id),
                    body: items
                )
                sectionModels.append(sectionModel)
            case let .categories(id, categories):
                let sectionModel = SectionModel(
                    section: .categories(id: id),
                    body: [
                        .categoriesScroller(id: id, titles: categories.titles)
                    ]
                )
                sectionModels.append(sectionModel)
            case let .featuredCourse(id, course):
                let sectionModel = SectionModel(
                    section: .featureCourse(id: id),
                    body: [
                        .featureCourse(
                            id: course.id,
                            imageLink: course.imageLink,
                            title: course.title,
                            author: course.author,
                            rating: course.rating,
                            reviewCount: course.reviewCount,
                            price: course.price
                        )
                    ]
                )
                sectionModels.append(sectionModel)
            case let .udemyBusinessBanner(id, udemyBusinessBanner):
                let sectionModel = SectionModel(
                    section: .udemyBusinessBanner(id: id),
                    body: [
                        .udemyBusinessBanner(id: udemyBusinessBanner.id,
                                             link: udemyBusinessBanner.link)
                    ]
                )
                sectionModels.append(sectionModel)
            case let .unknown(type):
                print(">>>>>>>>>> Unknown type found - \(type)")
            }
        }
        
        return HomeUIModel(sectionModels: sectionModels)
    }
}
