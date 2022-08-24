//
//  ProductDetailViewController.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet var productImageView: UIImageView!

    @IBOutlet var productIdLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let productInfo = ProductInfoManager.shared.selectedProductInfo else {
            return
        }
        
        productImageView.sd_setImage(with: URL(string: productInfo.imageURL))
        productIdLabel.text = productInfo.martId
        priceLabel.text = productInfo.finalPrice
    }
}
