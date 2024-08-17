//
//  FeatureCourseCollectionViewCell.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SnapKit
import SwiftUI

final class FeatureCourseCollectionViewCell: UICollectionViewCell {
    
    private var hostingController: UIHostingController<FeatureCourseView>!
    
    var onTap: CustomHandler?
    
    func configure(imageLink: String, title: String, author: String, rating: Double, reviewCount: Int, price: Decimal) {
        guard hostingController == nil else { return }
        
        let featureView = FeatureCourseView(imageLink: imageLink, title: title, author: author, rating: rating, reviewCount: reviewCount, price: price)
        hostingController = UIHostingController(rootView: featureView)
        addSubview(hostingController.view)
        hostingController.view.clipsToBounds = true
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hostingController.rootView.onTap = { [weak self] in
            self?.onTap?()
        }
    }
}

