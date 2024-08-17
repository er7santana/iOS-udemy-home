//
//  Extension+UICollectionViewCell.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import UIKit

extension UICollectionViewCell {
    static var namedIdentifier: String {
        return String(describing: self)
    }
}
