//
//  ProductDetailViewModel.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 14/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

typealias ProductDetailFetchCompletion = (Bool, Error?) -> Void

class ProductDetailViewModel {
    
    
    private var networkManager: NetworkingProtocol = NetworkManager()
    
    var contentItemDetail: Products? // for unit test we can set this model
    
    init() {}
    
    convenience init(networkClient: NetworkingProtocol) { // for unit test we can inject the client
        self.init()
        self.networkManager = networkClient
    }
    
    func getMovieDetail(pId: String, completion: @escaping ProductDetailFetchCompletion) {
        
        networkManager.request(endPoint: ProductDelasFetchApi.fetchProductDetail(id: pId)) { [weak self] (result: Products?, error: Error?) in
            
            guard error == nil, let result_ = result else {
                           completion(false, error)
                           return }
            self?.contentItemDetail = result_
            completion(true, nil)
        }
    }
    
    func getMovieTitle() -> String {
        return contentItemDetail?.title ?? ""
    }
    
    func getPriceDetail() -> String {
        return contentItemDetail?.regular_price?.display_string ?? "0.0"
    }
    
    func getProductDetail() -> String {
        return contentItemDetail?.description ?? ""
    }
    
}


