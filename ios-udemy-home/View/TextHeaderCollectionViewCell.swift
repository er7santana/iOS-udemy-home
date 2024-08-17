//
//  TextHeaderCollectionViewCell.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SnapKit
import UIKit

final class TextHeaderCollectionViewCell: UICollectionViewCell {
    
    let label = AttributedTappableLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(text: String, highlightedText: String?) {
        label.setAttributedText(
            text: text,
            highlightedText: highlightedText,
            color: .systemIndigo,
            font: .systemFont(ofSize: 18, weight: .bold)
        )
    }
    
    func layout() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.onTap = {
            print(">>>>>>>>>>>> tapped")
        }
    }
}
