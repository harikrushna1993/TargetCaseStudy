//
//  DetailViewController.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 15/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageviewProductDetail: UIImageView!
    @IBOutlet weak var labelPriceDetail: UILabel!
    @IBOutlet weak var labelProductDescription: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> DetailViewController {
        
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: Bundle.main)
        viewController.coordinator = coordinator
        return viewController
    }

    fileprivate var coordinator: TempoCoordinator!
    var viewActionService: MainViewAction?
    var pId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkingService = NetworkService()
        viewActionService = MainViewAction(dispatcher: coordinator.dispatcher, networkService: networkingService)
        viewActionService?.fetchProductDetail(id: pId ?? 0)
        
        let mainViewPresenter = MainViewPresenter(activityIndicator: activityIndicator)
        let detailiewPresenter = ProductDetailPresenter(productImage: imageviewProductDetail, priceLabel: labelPriceDetail, descriptionLabel: labelProductDescription)
        
        coordinator.presenters = [mainViewPresenter,
                                  detailiewPresenter
        ]
        
    }
    
}
