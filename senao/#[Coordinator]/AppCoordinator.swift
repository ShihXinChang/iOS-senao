//
//  AppCoordinator.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import UIKit

class AppCoordinator: NSObject {
    var keyWindow: UIWindow!
    var mainStoryBorad: UIStoryboard!
    var mainNavc: UINavigationController!
    var productListVC: ProductListViewController!
    var productDetailVC: ProductDetailViewController!

    init(window: UIWindow) {
        keyWindow = window
    }
    
    func start() {
        mainStoryBorad = UIStoryboard(name: "Main", bundle: Bundle.main)
        mainNavc = mainStoryBorad.instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController
        productListVC = mainNavc.topViewController as? ProductListViewController
        productListVC.delegate = self
        
        keyWindow.rootViewController = mainNavc
        keyWindow.makeKeyAndVisible()
    }
    
}

extension AppCoordinator: ProductListViewControllerDelegate {
    func productListViewControllerDidSelectTable() {
        productDetailVC = mainStoryBorad.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController
        mainNavc.pushViewController(productDetailVC, animated: true)
    }
}
