//
//  Item.swift
//  NasaNews
//
//  Created by Tzy on 25.03.2022.
//

import Foundation

struct Item: Decodable {
    let title: String
    let date: String
    let body: String
    let itemName: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case date
        case body
        case itemName = "item_name"
    }
}
