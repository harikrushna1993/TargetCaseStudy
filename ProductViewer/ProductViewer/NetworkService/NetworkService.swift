//
//  NetworkService.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 15/06/21.
//  Copyright © 2021 Target. All rights reserved.Service
//

import Foundation
import Tempo

enum ResultType {
    case success
    case failure
}

protocol NetworkingServiceProtocol {
    func request<T: Decodable>(endPoint: EndPointType, completion: @escaping (T?, Error?) -> ())
}

class NetworkService: NetworkingServiceProtocol {
    
    func request<T: Decodable>(endPoint: EndPointType, completion: @escaping (T?, Error?) -> ()) {
        let request = buildRequest(from: endPoint)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, error)
                        return
                    }
                    do {
                        print(responseData)
                        let value = try JSONDecoder().decode(T.self, from: responseData)
                        completion(value, nil)
                        return
                    }
                    catch {
                        completion(nil, error)
                        print(error)
                    }
                case .failure:
                    completion(nil, error)
                }
                
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
}

extension NetworkService {

    fileprivate func buildRequest(from route: EndPointType) -> URLRequest {

        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        if let qParam = route.queryParams {
            for (key,val) in qParam {
                request.url?.appendQueryItem(name: key, value: val)
            }
        }
        
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
       
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> ResultType{
        switch response.statusCode {
        case 200...299: return .success
        case 401...600: return .failure
        default: return .failure
        }
    }
}

