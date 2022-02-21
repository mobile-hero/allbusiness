//
//  ApplicationCoordinator.swift
//
//  Created by Muhammad Ikhsan on 11/02/22.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let listCoordinator: BusinessListCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        
//        rootViewController.toolbar.backgroundColor = .navigation
//        rootViewController.navigationBar.backgroundColor = .navigation
//        rootViewController.toolbar.tintColor = .text
//        let size = CGSize(width: window.bounds.width, height: 72)
//        let toolbarImage = UIGraphicsImageRenderer(size: size).image { rendererContext in
//            UIColor.navigation.setFill()
//            rendererContext.fill(CGRect(origin: .zero, size: size))
//        }
//        rootViewController.navigationBar.setBackgroundImage(toolbarImage, for: .default)
        
        listCoordinator = BusinessListCoordinator(navigationController: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        listCoordinator.start()
        window.makeKeyAndVisible()
    }
}
