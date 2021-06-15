//
//  DetailViewState.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 15/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

struct ProductDetailViewState: TempoViewState {
    var imageUrl: String?
    var price: String?
    var description: String?
}
    
func ==(lhs: ProductDetailViewState, rhs: ProductDetailViewState) -> Bool {
    return lhs.imageUrl == rhs.imageUrl && lhs.price == rhs.price && lhs.description == rhs.description
}
