//
//  FetchType.swift
//  StocksApp
//
//  Created by Asset on 1/18/25.
//

import Foundation

enum FetchType {
    case logoName(_ ticker: String)
    case prices(_ ticker: String)
    
    var urlString: String {
        switch self {
        case .logoName(let ticker):
            return "https://finnhub.io/api/v1/stock/profile2?symbol=\(ticker)&token="
        case .prices(let ticker):
            return "https://finnhub.io/api/v1/quote?symbol=\(ticker)&token="
        }
    }
}
