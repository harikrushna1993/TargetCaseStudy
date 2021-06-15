//
//  MainViewPresenter.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

class MainViewPresenter: TempoPresenterType {
   
    let activityIndicator: UIActivityIndicatorView

    init(activityIndicator: UIActivityIndicatorView) {
        self.activityIndicator = activityIndicator
    }

    func present(_ viewState: TempoViewState) {
        if let viewState = viewState as? MainViewState {
            switch viewState.viewStatus {
            case .fetching, .ready:
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            case .fetched:
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            default:
                break
            }
        }
    }
}




