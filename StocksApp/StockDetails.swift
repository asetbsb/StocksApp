//
//  StockStruct.swift
//  StocksApp
//
//  Created by Asset on 11/26/24.
//

import Foundation
import UIKit

struct StockDetails {
    let ticker: String
    var isFavorite: FavoriteState
    var name: String
    var currentPrice: String
    var priceChange: String
    var logo: String
    var priceChangeColor: UIColor
    var logoImage: UIImage
}
