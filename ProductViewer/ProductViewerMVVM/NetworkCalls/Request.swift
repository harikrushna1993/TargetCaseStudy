//
//  Request.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

public enum ProductDelasFetchApi {
    case fetchProductList
    case fetchProductDetail(id: String)
}

extension ProductDelasFetchApi: EndPointType {
    
    var baseURL: URL {
        guard  let url = URL(string: NetworkConstant.baseUrl)  else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }

    var path: String {
        switch self {
        case .fetchProductList:
            return "deals"
        case .fetchProductDetail(let id):
            return "deals/\(id)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .fetchProductList, .fetchProductDetail:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
    
    var queryParams: QueryParam? {
        switch self {
        case .fetchProductList, .fetchProductDetail:
            return  nil
        }
    }
}

extension URL {

    mutating func appendQueryItem(name: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        self = urlComponents.url!
    }
}


