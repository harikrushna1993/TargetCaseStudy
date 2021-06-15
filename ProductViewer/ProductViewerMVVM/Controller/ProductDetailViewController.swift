//
//  ProductDetailViewController.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var imageViewProductDetail: UIImageView!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var labelProductPriceDetail: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var product: Products?
    private let productDetailViewModel = ProductDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProductDetails()
    }
    
    private func showActivityIndicator(status: Bool) {
        if status {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
   private func fetchProductDetails() {
        showActivityIndicator(status: true)
        productDetailViewModel.getMovieDetail(pId: "\(product?.id ?? 0)") { [weak self] (status, error) in
            if status && error == nil {
                DispatchQueue.main.async {
                    self?.showActivityIndicator(status: false)
                    self?.setProductDetail()
                }
            }
        }
    }
    
   private func setProductDetail() {
        imageViewProductDetail.loadImageWithPlaceHolder(at: product?.image_url ?? "", placeHolder: #imageLiteral(resourceName: "Placeholder"))
        labelProductPrice.text = product?.regular_price?.display_string
        labelProductPriceDetail.text = product?.description
    }
    
}
