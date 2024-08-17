//
//  CategoriesCollectionViewCell.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SnapKit
import SwiftUI

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    private var hostingController: UIHostingController<CategoriesView>!
    
    var onTap: ((String) -> Void)?
    
    func configure(titles: [String]) {
        guard hostingController == nil else { return }
        let categoriesView = CategoriesView(titles: titles)
        hostingController = UIHostingController(rootView: categoriesView)
        guard let hostingController else { return }
        addSubview(hostingController.view)
        hostingController.view.clipsToBounds = true
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hostingController.rootView.onTap = { [weak self] title in
            self?.onTap?(title)
        }
    }
}
