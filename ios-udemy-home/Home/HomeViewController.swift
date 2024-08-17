//
//  HomeViewController.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import Combine
import SnapKit
import UIKit

class HomeViewController: UIViewController {
    
    private let collectionView = HomeCollectionView()
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        observe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let uiModel = HomeUIModel(sectionModels: [
            .init(section: .mainBanner(id: UUID().uuidString),
                  body: [
                    .mainBanner(id: UUID().uuidString,
                                imageLink: "https://cms.santander.com.br/sites/WPS/imagem/img-cartao-quartz-aa/22-09-16_181507_P_cartao-quartz-aa.png",
                                title: "Some title",
                                caption: "Some caption"
                               )
                  ]),
            .init(section: .textHeader(id: UUID().uuidString),
                  body: [
                    .textHeader(id: UUID().uuidString,
                                text: "Newest courses in Mobile Development",
                                highlightedText: "Mobile Development")
                  ]),
            .init(section: .courseSwimLane(id: UUID().uuidString),
                  body: [
                    .course(id: UUID().uuidString,
                            imageLink: "https://cms.santander.com.br/sites/MOB_Propostas/imagemproposta/campo-boxer-cmc/24-08-13_193036_P_banner_lp_aproveite_beneficios_c+c_desktop_v2.jpg",
                            title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                            author: "Kevin Fok",
                            rating: 4.5,
                            reviewCount: 224,
                            price: 19.99,
                            tag: "Bestseller"
                           ),
                    .course(id: UUID().uuidString,
                            imageLink: "https://cms.santander.com.br/sites/MOB_Propostas/imagemproposta/campo-boxer-cmc/24-08-13_193036_M_banner_lp_pre_venda_shows_c+c_v2.jpg",
                            title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                            author: "Kevin Fok",
                            rating: 4.5,
                            reviewCount: 224,
                            price: 19.99,
                            tag: "Bestseller"
                           ),
                    .course(id: UUID().uuidString,
                            imageLink: "https://cms.santander.com.br/sites/WPS/imagem/imagem-nova-loja-cartao-smiles-gold/21-06-16_162806_P_smiles_gold_vs.png",
                            title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                            author: "Kevin Fok",
                            rating: 4.5,
                            reviewCount: 224,
                            price: 19.99,
                            tag: "Bestseller"
                           ),
                    .course(id: UUID().uuidString,
                            imageLink: "https://cms.santander.com.br/sites/WPS/imagem/imagem-nova-loja-cartao-unique-black/23-12-20_190828_P_unique.png",
                            title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                            author: "Kevin Fok",
                            rating: 4.5,
                            reviewCount: 224,
                            price: 19.99,
                            tag: "Bestseller"
                           ),
                  ]),
            .init(section: .textHeader(id: UUID().uuidString),
                  body: [
                    .textHeader(id: UUID().uuidString,
                                text: "Categories",
                                highlightedText: nil)
                  ]),
            .init(section: .categories(id: UUID().uuidString),
                  body: [
                    .categoriesScroller(id: UUID().uuidString,
                                        titles: Category.allCases.map { $0.rawValue.camelCaseToEnglish.useShortAndFormat.capitalized })
                  ]),
            .init(section: .textHeader(id: UUID().uuidString),
                  body: [
                    .textHeader(id: UUID().uuidString,
                                text: "Because you viewed \"How to land yourself a role\"",
                                highlightedText: "\"How to land yourself a role\"")
                  ]),
            .init(section: .courseSwimLane(id: UUID().uuidString),
                  body: [
                    .course(id: UUID().uuidString,
                            imageLink: "https://cms.santander.com.br/sites/MOB_Propostas/imagemproposta/campo-boxer-cmc/24-08-13_193036_P_banner_lp_aproveite_beneficios_c+c_desktop_v2.jpg",
                            title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                            author: "Kevin Fok",
                            rating: 4.5,
                            reviewCount: 224,
                            price: 19.99,
                            tag: "Bestseller"
                           ),
                    .course(id: UUID().uuidString,
                            imageLink: "https://cms.santander.com.br/sites/MOB_Propostas/imagemproposta/campo-boxer-cmc/24-08-13_193036_M_banner_lp_pre_venda_shows_c+c_v2.jpg",
                            title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                            author: "Kevin Fok",
                            rating: 4.5,
                            reviewCount: 224,
                            price: 19.99,
                            tag: "Bestseller"
                           ),
                    .course(id: UUID().uuidString,
                            imageLink: "https://cms.santander.com.br/sites/WPS/imagem/imagem-nova-loja-cartao-smiles-gold/21-06-16_162806_P_smiles_gold_vs.png",
                            title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                            author: "Kevin Fok",
                            rating: 4.5,
                            reviewCount: 224,
                            price: 19.99,
                            tag: "Bestseller"
                           ),
                    .course(id: UUID().uuidString,
                            imageLink: "https://cms.santander.com.br/sites/WPS/imagem/imagem-nova-loja-cartao-unique-black/23-12-20_190828_P_unique.png",
                            title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                            author: "Kevin Fok",
                            rating: 4.5,
                            reviewCount: 224,
                            price: 19.99,
                            tag: "Bestseller"
                           ),
                  ]),
            .init(section: .textHeader(id: UUID().uuidString),
                  body: [
                    .textHeader(id: UUID().uuidString,
                                text: "Top course of the year",
                                highlightedText: nil)
                  ]),
            .init(section: .featureCourse(id: UUID().uuidString),
                  body: [
                    .featureCourse(id: UUID().uuidString,
                                   imageLink: "https://cms.santander.com.br/sites/WPS/imagem/imagem-nova-loja-cartao-unique-black/23-12-20_190828_P_unique.png",
                                   title: "iOS & Swift: Server Driven UI Compositional Layout & SwiftUI",
                                   author: "Kevin Fok",
                                   rating: 4.5,
                                   reviewCount: 224,
                                   price: 19.99
                                  )
                  ]),
            .init(section: .udemyBusinessBanner(id: UUID().uuidString),
                  body: [
                    .udemyBusinessBanner(id: UUID().uuidString,
                                         link: "https://www.santander.com.br")
                  ])
        ])
        
        collectionView.setDataSource(uiModel: uiModel)
    }
    
    private func observe() {
        collectionView.eventPublisher.sink { [weak self] event in
            switch event {
            case let .itemTapped(item):
                self?.handleItemTapped(item: item)
                break
            }
        }
        .store(in: &cancellables)
    }
    
    private func handleItemTapped(item: HomeUIModel.Item) {
        switch item {
        case .mainBanner(let id, let imageLink, let title, let caption):
            print(">>>>>>>> mainBanner tapped")
        case .course(let id, let imageLink, let title, let author, let rating, let reviewCount, let price, let tag):
            print(">>>>>>>> course tapped \(id)")
        case .textHeader(let id, let text, let highlightedText):
            print(">>>>>>>> textHeader tapped")
        case .udemyBusinessBanner(let id, let link):
            print(">>>>>>>> businessBanner tapped")
        case .categoriesScroller(let id, let titles):
            print(">>>>>>>> categories tapped \(titles.first ?? "")")
        case .featureCourse(let id, let imageLink, let title, let author, let rating, let reviewCount, let price):
            print(">>>>>>>> feature tapped")
        }
    }
    
    func setupView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! HomeViewController
    return UINavigationController(rootViewController: viewController)
    
}
