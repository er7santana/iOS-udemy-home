//
//  UdemyBusinessCollectionViewCell.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SnapKit
import SwiftUI

final class UdemyBusinessCollectionViewCell: UICollectionViewCell {
    
    private var hostingController: UIHostingController<UdemyBusinessView>!
    
    var onTap: CustomHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    private func layout() {
        hostingController = UIHostingController(rootView: UdemyBusinessView())
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
