//
//  ListEvents.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo
import Foundation

struct ListItemPressed: EventType {
    let id: Int
}

struct ListItemFetched: EventType {
    var response: ProductList?
    var error: Error?
}

struct ProductDetailFetched: EventType {
    var response: Products?
    var error: Error?
}
