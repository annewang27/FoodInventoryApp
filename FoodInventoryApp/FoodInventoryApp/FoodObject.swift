//
//  FoodObject.swift
//  FoodInventoryApp
//
//  Created by Anne Wang on 2020-04-23.
//  Copyright © 2020 Anne Wang. All rights reserved.
//

import Foundation

struct FoodObject: Hashable, Codable {
    var name: String
    var quantity: String
    var starred: Bool

    init(Name: String = "", Quantity: String = "", Starred: Bool = false) {
        name = Name
        quantity = Quantity
        starred = Starred
    }
}

class FoodList: ObservableObject {
    @Published var objects = [FoodObject]()
}
