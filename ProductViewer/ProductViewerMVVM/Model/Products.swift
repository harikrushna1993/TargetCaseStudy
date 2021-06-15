//
//  Products.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
struct ProductList : Codable {
    let products : [Products]?

    enum CodingKeys: String, CodingKey {

        case products = "products"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
    }

}

struct Products : Codable {
    let id : Int?
    let title : String?
    let aisle : String?
    let description : String?
    let image_url : String?
    let regular_price : Regular_price?
    let sale_price : Sale_price?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case aisle = "aisle"
        case description = "description"
        case image_url = "image_url"
        case regular_price = "regular_price"
        case sale_price = "sale_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        aisle = try values.decodeIfPresent(String.self, forKey: .aisle)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        regular_price = try values.decodeIfPresent(Regular_price.self, forKey: .regular_price)
        sale_price = try values.decodeIfPresent(Sale_price.self, forKey: .sale_price)
    }

}

struct Regular_price : Codable {
    let amount_in_cents : Int?
    let currency_symbol : String?
    let display_string : String?

    enum CodingKeys: String, CodingKey {

        case amount_in_cents = "amount_in_cents"
        case currency_symbol = "currency_symbol"
        case display_string = "display_string"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount_in_cents = try values.decodeIfPresent(Int.self, forKey: .amount_in_cents)
        currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
        display_string = try values.decodeIfPresent(String.self, forKey: .display_string)
    }

}

struct Sale_price : Codable {
    let amount_in_cents : Int?
    let currency_symbol : String?
    let display_string : String?

    enum CodingKeys: String, CodingKey {

        case amount_in_cents = "amount_in_cents"
        case currency_symbol = "currency_symbol"
        case display_string = "display_string"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount_in_cents = try values.decodeIfPresent(Int.self, forKey: .amount_in_cents)
        currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
        display_string = try values.decodeIfPresent(String.self, forKey: .display_string)
    }

}
