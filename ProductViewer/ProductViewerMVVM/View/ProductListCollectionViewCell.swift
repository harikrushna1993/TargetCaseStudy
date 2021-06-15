//
//  ProductListCollectionViewCell.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageviewProductDetail: UIImageView!
    @IBOutlet weak var labelProductTitle: UILabel!
    @IBOutlet weak var labelPriceDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadContentDetail(contentItem: Products) {
        labelProductTitle.text = contentItem.title
        labelPriceDetail.text = contentItem.regular_price?.display_string
        guard let pImg = contentItem.image_url else {
            return }
        imageviewProductDetail.loadImageWithPlaceHolder(at: pImg, placeHolder: #imageLiteral(resourceName: "Placeholder"))
    }
}
