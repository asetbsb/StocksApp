//
//  JsonData.swift
//  StocksApp
//
//  Created by Asset on 1/15/25.
//

import Foundation

struct StockLogoNameData: Codable {
    let logo: String
    let name: String
}

struct StockPricesData: Codable {
    let currentPrice: Double
    let priceChange: Double
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "c"
        case priceChange = "d"
    }
}
