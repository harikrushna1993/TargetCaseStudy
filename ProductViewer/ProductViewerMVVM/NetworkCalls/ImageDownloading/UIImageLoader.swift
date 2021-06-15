//
//  UIImageviewLoading.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import UIKit

class UIImageLoader {
  static let loader = UIImageLoader()

  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()

  private init() {}

  func load(_ url: String, for imageView: UIImageView) {

    guard let url = URL(string: url) else { return }
    
    let token = imageLoader.loadImage(url) { result, error in
      
      defer { self.uuidMap.removeValue(forKey: imageView) }
     
        guard let image =  result else { return }
        DispatchQueue.main.async {
          imageView.image = image
        }
    }
    if let token = token {
      uuidMap[imageView] = token
    }
  }

  func cancel(for imageView: UIImageView) {
    if let uuid = uuidMap[imageView] {
      imageLoader.cancelLoad(uuid)
      uuidMap.removeValue(forKey: imageView)
    }
  }
}

