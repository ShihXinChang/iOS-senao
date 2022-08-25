//
//  ProductInfoCell.swift
//  senao
//
//  Created by 張仕欣 on 2022/8/24.
//

import UIKit
import SDWebImage

class ProductInfoCell: UITableViewCell {
    
    @IBOutlet var cornerBackgroundView: UIView!
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerBackgroundView.layer.cornerRadius = 10
    }
    
    var item: ProductInfo? {
        didSet {
            guard let item = item else {
                return
            }
            
            productImageView.sd_setImage(with: URL(string: item.imageURL), placeholderImage: UIImage(named: "defaultImage"))
            nameLabel.text = item.name
            priceLabel.text = item.price_moneyFormat
        }
    }
}
