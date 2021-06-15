//
//  ImageDownloading.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    private var loadedImages = NSCache<NSURL, UIImage>()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (UIImage?, Error?) -> Void) -> UUID? {
        
        if let image = loadedImages.object(forKey: url as NSURL) {
            completion(image, nil)
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            defer {self?.runningRequests.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
                self?.loadedImages.setObject(image, forKey: url as NSURL)
                completion(image, nil)
                return
            }
            if let _ = error {
                completion(nil, error)
                return
            }
        }
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}

