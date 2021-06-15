//
//  UIImageView.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageWithPlaceHolder(at url: String, placeHolder: UIImage?) {
        self.image = placeHolder
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
