//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
        
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
            updateListUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
        didSet {
            updateListUI()
        }
    }
    
    fileprivate var mainViewState: MainViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            if ((presenter as? MainViewPresenter) != nil) {
                presenter.present(mainViewState)
            }
        }
    }
    
    fileprivate func updateListUI() {
        for presenter in presenters {
            if ((presenter as? SectionPresenter) != nil) {
                presenter.present(viewState)
            }
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        mainViewState = MainViewState(viewStatus: .ready)
        registerListeners()
        registerFetchProductListeners()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] event in
            let detail = DetailCoordinator()
            detail.viewController.pId = event.id
            self?.viewController.present(detail.viewController, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String, actionButtonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        viewController.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func registerFetchProductListeners() {
        dispatcher.addObserver(ListItemFetched.self) { [weak self] event in
            DispatchQueue.main.async {
                self?.mainViewState.viewStatus = .fetched
                guard event.error == nil, let responseData = event.response?.products, responseData.count > 0 else {
                    self?.showAlert(title: "Error", message: event.error?.localizedDescription ?? "", actionButtonTitle: "ok")
                    return
                }
                self?.viewState.listItems = responseData.map { data in
                    ListItemViewState(title: data.title ?? "", price: data.regular_price?.display_string ?? "", imageUri: data.image_url ?? "", id: data.id)
                }
            }
        }
    }
}
