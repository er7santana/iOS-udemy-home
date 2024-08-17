//
//  HomeViewController.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SnapKit
import UIKit

class HomeViewController: UIViewController {
    
    private let collectionView = HomeCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let uiModel = HomeUIModel(sectionModels: [
            .init(section: .mainBanner(id: "123"),
                  body: [
                    .mainBanner(id: "234",
                                imageLink: "https://cms.santander.com.br/sites/WPS/imagem/img-cartao-quartz-aa/22-09-16_181507_P_cartao-quartz-aa.png",
                                title: "Some title",
                                caption: "Some caption"
                               )
                  ])
        ])
        
        collectionView.setupUIModel(uiModel: uiModel)
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
