//
//  DetailCoordinator.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 15/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

class DetailCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
        
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
            updateDetailUI()
        }
    }
    
    fileprivate var mainViewState: MainViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var detailViewState: ProductDetailViewState {
        didSet {
            updateDetailUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            if ((presenter as? MainViewPresenter) != nil) {
                presenter.present(mainViewState)
            }
        }
    }
    
    fileprivate func updateDetailUI() {
        for presenter in presenters {
            if ((presenter as? ProductDetailPresenter) != nil) {
                presenter.present(detailViewState)
            }
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: DetailViewController = {
        return DetailViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        mainViewState = MainViewState(viewStatus: .ready)
        detailViewState = ProductDetailViewState()
        registerFetchProductDetailListeners()
    }
    
    // MARK: DetailCoordinator
    
    func showAlert(title: String, message: String, actionButtonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        viewController.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func registerFetchProductDetailListeners() {
        dispatcher.addObserver(ProductDetailFetched.self) { [weak self] event in
            DispatchQueue.main.async {
                self?.mainViewState.viewStatus = .fetched
                guard event.error == nil, let responseData = event.response else {
                    self?.showAlert(title: "Error", message: event.error?.localizedDescription ?? "", actionButtonTitle: "ok")
                    return
                }
                self?.detailViewState = ProductDetailViewState(imageUrl: responseData.image_url ?? "", price: responseData.regular_price?.display_string ?? "", description: responseData.description ?? "")
            }
        }
    }
}

