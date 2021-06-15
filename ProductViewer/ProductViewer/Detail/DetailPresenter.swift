//
//  DetailPresenter.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 15/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

class ProductDetailPresenter: TempoPresenterType {
   
    let productImage: UIImageView
    let priceLabel: UILabel
    let descriptionLabel: UILabel
    
    
    init(productImage: UIImageView, priceLabel: UILabel, descriptionLabel: UILabel) {
        self.productImage = productImage
        self.priceLabel = priceLabel
        self.descriptionLabel = descriptionLabel
    }

    func present(_ viewState: TempoViewState) {
        if let viewState = viewState as? ProductDetailViewState {
            priceLabel.text = viewState.price
            descriptionLabel.text = viewState.description
            productImage.loadImageWithPlaceHolder(at: viewState.imageUrl ?? "", placeHolder: #imageLiteral(resourceName: "Placeholder"))
        }
    }
}
