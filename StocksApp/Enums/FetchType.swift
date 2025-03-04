//
//  FetchType.swift
//  StocksApp
//
//  Created by Asset on 1/18/25.
//

import Foundation

enum FetchType {
    case logoAndName(_ ticker: String)
    case priceInfo(_ ticker: String)
    
    var urlString: String {
        switch self {
        case .logoAndName(let ticker):
            return "https://finnhub.io/api/v1/stock/profile2?symbol=\(ticker)&token="
        case .priceInfo(let ticker):
            return "https://finnhub.io/api/v1/quote?symbol=\(ticker)&token="
        }
    }
}
