//
//  ProductDetailViewController.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import UIKit

protocol ProductDetailViewControllerDelegate {
    func productDetailViewControllerShouldTurnBack()
}

class ProductDetailViewController: UIViewController {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productIdLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    var delegate: ProductDetailViewControllerDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackBarButtonItem()
        
        guard let productInfo = ProductInfoManager.shared.selectedProductInfo else {
            return
        }
        
        productImageView.sd_setImage(with: URL(string: productInfo.imageURL))
        productIdLabel.text = productInfo.idNumber
        priceLabel.text = productInfo.price_moneyFormat
    }
}

// MARK: UI click methods
extension ProductDetailViewController {
    @objc func backBarButtonItemDidTap(backBarButtonItem: UIBarButtonItem) {
        delegate?.productDetailViewControllerShouldTurnBack()
    }
}

// MARK: custom UI
extension ProductDetailViewController {
    func setupBackBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-navigationItem_back"), style: .plain, target: self, action: #selector(backBarButtonItemDidTap(backBarButtonItem:)))
    }
}
