//
//  PreviewViewController.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/15.
//

import UIKit

/// MVC の View をプレビューするための ViewController
final class PreviewViewController: UIViewController {
    // MARK: Lifecycle
    
    init(view: UIView) {
        super.init(nibName: nil, bundle: nil)
        self.view = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
