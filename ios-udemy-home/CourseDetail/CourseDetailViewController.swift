//
//  CourseDetailViewController.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import SnapKit
import SwiftUI

final class CourseDetailViewController: UIViewController {
    
    private var hostingViewController: UIHostingController<CourseDetailView>!
    let courseTitle: String
    
    init(courseTitle: String) {
        self.courseTitle = courseTitle
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
   
    func setup() {
        hostingViewController = UIHostingController(rootView: CourseDetailView(title: courseTitle))
        view.addSubview(hostingViewController.view)
        hostingViewController.view.clipsToBounds = true
        hostingViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    return UINavigationController(rootViewController: CourseDetailViewController(courseTitle: "How to become a Senior iOS Engineer"))
}
