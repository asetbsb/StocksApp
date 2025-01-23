//
//  StocksBrain.swift
//  StocksApp
//
//  Created by Asset on 11/26/24.
//

import Foundation

struct StocksList {
    var tickerNames: [String] = [
        "AAPL", // Apple Inc.
        "MSFT", // Microsoft Corporation
        "GOOGL", // Alphabet Inc. (Google)
        "AMZN", // Amazon.com Inc.
        "TSLA", // Tesla Inc.
        "META", // Meta Platforms Inc.
        "NFLX", // Netflix Inc.
        "NVDA", // NVIDIA Corporation
        "BRK.B", // Berkshire Hathaway Inc.
        "V", // Visa Inc.
        "JNJ",  // Johnson & Johnson
        "WMT",  // Walmart Inc.
        "PG", // Procter & Gamble Co.
        "DIS",  // The Walt Disney Company
        "HD", // Home Depot Inc.
        "MA", // Mastercard Inc.
        "XOM",  // Exxon Mobil Corporation
        "KO", // The Coca-Cola Company
        "PEP",  // PepsiCo Inc.
        "NKE"   // Nike Inc.
    ]
}

//var stocksList: [StockDetails]
//var networkingManager = NetworkingManager()
//
//var tickerNames: [String] = [
//    "AAPL", // Apple Inc.
//    "MSFT", // Microsoft Corporation
//    "GOOGL", // Alphabet Inc. (Google)
//    "AMZN", // Amazon.com Inc.
//    "TSLA", // Tesla Inc.
//    "META", // Meta Platforms Inc.
//    "NFLX", // Netflix Inc.
//    "NVDA", // NVIDIA Corporation
//    "BRK.B", // Berkshire Hathaway Inc.
//    "V", // Visa Inc.
//    "JNJ",  // Johnson & Johnson
//    "WMT",  // Walmart Inc.
//    "PG", // Procter & Gamble Co.
//    "DIS",  // The Walt Disney Company
//    "HD", // Home Depot Inc.
//    "MA", // Mastercard Inc.
//    "XOM",  // Exxon Mobil Corporation
//    "KO", // The Coca-Cola Company
//    "PEP",  // PepsiCo Inc.
//    "NKE",  // Nike Inc.
//]

//mutating func fetchStocks() {
//    for ticker in tickerNames {
//
//        var stock: StockDetails = StockDetails(ticker: ticker, isFavorite: .notFavorite, name: "", currentPrice: "", priceChange: "", logo: "")
        
//        networkingManager.fetchData(type: .logoName(ticker), responseType: StockLogoNameData.self) { result in
//            switch result {
//            case .success(let data):
//                stock.logo = data.logo
//                stock.name = data.name
//            case .failure(let error):
//                print("Error fetching logo: \(error)")
//            }
//        }

//        networkingManager.fetchData(type: .prices(ticker), responseType: StockPriceData.self) { result in
//            switch result {
//            case .success(let data):
//                stock.currentPrice = "$" + String(data.currentPrice)
//                stock.priceChange = "+$" + String(data.priceChange)
//            case .failure(let error):
//                print("Error fetching stock info: \(error)")
//            }
//        }
//
//        self.stocksList.append(stock)
//    }
//}
