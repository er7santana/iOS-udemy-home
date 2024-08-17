//
//  CourseCollectionViewCell.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SnapKit
import SwiftUI

final class CourseCollectionViewCell: UICollectionViewCell {
    
    private var hostingController: UIHostingController<CourseView>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(imageLink: String, title: String, author: String, rating: Double, reviewCount: Int, price: Decimal, tag: String) {
        guard hostingController == nil else { return }
        let courseView = CourseView(imageLink: imageLink, title: title, author: author, rating: rating, reviewCount: reviewCount, price: price, tag: tag)
        
        hostingController = UIHostingController(rootView: courseView)
        addSubview(hostingController.view)
        hostingController.view.clipsToBounds = true
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
