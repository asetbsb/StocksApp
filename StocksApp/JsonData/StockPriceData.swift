//
//  StockPriceData.swift
//  StocksApp
//
//  Created by Asset on 1/23/25.
//

import Foundation

struct StockPriceData: Codable {
    let currentPrice: Double
    let priceChange: Double
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "c"
        case priceChange = "d"
    }
}
