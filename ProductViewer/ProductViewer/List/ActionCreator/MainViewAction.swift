//
//  MainViewAction.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 15/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

// Referenced from https://www.freecodecamp.org/news/an-introduction-to-the-flux-architectural-pattern-674ea74775c9/

class MainViewAction {
    
    var dispatcher: Dispatcher?
    var networkService: NetworkingServiceProtocol?

    init(dispatcher: Dispatcher, networkService: NetworkingServiceProtocol) {
        self.dispatcher = dispatcher
        self.networkService = networkService
    }
    
    func fetchProductList() {
        networkService?.request(endPoint: ProductDelasFetchApi.fetchProductList, completion: { [weak self] (result: ProductList?, error: Error?) in
            self?.dispatcher?.triggerEvent(ListItemFetched(response: result, error: error))
        })
    }
    
    func fetchProductDetail(id: Int) {
        networkService?.request(endPoint: ProductDelasFetchApi.fetchProductDetail(id: "\(id)"), completion: { [weak self] (result: Products?, error: Error?) in
            self?.dispatcher?.triggerEvent(ProductDetailFetched(response: result, error: error))
        })
    }
    
}








