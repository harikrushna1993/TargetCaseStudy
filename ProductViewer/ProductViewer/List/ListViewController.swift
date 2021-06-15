//
//  ListViewController.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

class ListViewController: UIViewController {
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> ListViewController {
        let viewController = ListViewController()
        viewController.coordinator = coordinator
        return viewController
    }
    
    fileprivate var coordinator: TempoCoordinator!
    var viewActionService: MainViewAction?
    
    lazy var collectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .narrow, left: .none)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .none, left: .none)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: harmonyLayout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        activityIndicatorView.hidesWhenStopped = false
        activityIndicatorView.style = .gray
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addAndPinSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        view.bringSubviewToFront(activityIndicator)

        title = "checkout"
        let networkingService = NetworkService()
        
        viewActionService = MainViewAction(dispatcher: coordinator.dispatcher, networkService: networkingService)
        viewActionService?.fetchProductList()
        
        let components: [ComponentType] = [
            ProductListComponent()
        ]
        
        let componentProvider = ComponentProvider(components: components, dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView, componentProvider: componentProvider)
        let mainViewPresenter = MainViewPresenter(activityIndicator: activityIndicator)

        coordinator.presenters = [mainViewPresenter,
            SectionPresenter(adapter: collectionViewAdapter)
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
}

