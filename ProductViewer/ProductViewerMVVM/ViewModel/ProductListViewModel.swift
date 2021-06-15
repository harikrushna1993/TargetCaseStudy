//
//  ProductListViewModel.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

typealias ProductListFetchCompletion = (Bool, Error?) -> Void

class ProductListViewModel {
    
    private var networkManager: NetworkingProtocol = NetworkManager()
    var isFetchInProgress = false
    var contentItems: [Products]?
    var productListCount: Int {
        return contentItems?.count ?? 0
    }
    
    init() {
    }
    
    convenience init(networkClient: NetworkingProtocol) { // for unit test we can inject the client
        self.init()
        self.networkManager = networkClient
    }
    
    func getProductList(completion: @escaping ProductListFetchCompletion) {
        
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        
        networkManager.request(endPoint: ProductDelasFetchApi.fetchProductList) { [weak self] (result: ProductList?, error: Error?) in

            guard error == nil, let result_ = result else {
                self?.isFetchInProgress = false
                completion(false, error)
                return }

            guard let contentList = result_.products, contentList.count > 0 else {
                self?.isFetchInProgress = false
                completion(false, CustomError.noResult)
                return }

            self?.contentItems = contentList
           
            self?.isFetchInProgress = false
            completion(true, nil)
        }
    }
    
    func resetAllData() {
        contentItems?.removeAll()
    }

}
