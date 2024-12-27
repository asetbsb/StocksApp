//
//  StockLogoData.swift
//  StocksApp
//
//  Created by Asset on 12/12/24.
//

import Foundation

struct StockLogoData: Codable {
    let logo: String
    let name: String
}

struct StockInfoData: Codable {
    let c: Double
    let d: Double
}
