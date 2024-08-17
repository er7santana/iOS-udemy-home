//
//  ViewController.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SnapKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

@available(iOS 17.0, *)
#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
    return UINavigationController(rootViewController: viewController)
}
