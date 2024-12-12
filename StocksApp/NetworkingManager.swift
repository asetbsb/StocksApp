//
//  NetworkingManager.swift
//  StocksApp
//
//  Created by Asset on 12/11/24.
//

import Foundation

protocol StockDataDelegate {
    func uploadPhotoURL (_ imageURL: String)
    func uploadCurrentPrice ( _ currentPrice: Double)
    func uploadPriceChange (_ priceChange: Double)
}

struct NetworkingManager {
    
    var delegate: StockDataDelegate?
    
    let apiKey = "ctctrrpr01qlc0uvjqq0ctctrrpr01qlc0uvjqqg"

    func fetchStockLogo() {
        let urlString = "https://finnhub.io/api/v1/stock/profile2?symbol=AAPL&token=\(apiKey)"
        
        performLogoRequest(with: urlString)
    }
        
    func fetchStockInfo() {
        let urlString = "https://finnhub.io/api/v1/quote?symbol=AAPL&token=\(apiKey)"
        
        performInfoRequest(with: urlString)
    }
    
    func performLogoRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print(error!)
            }
            
            if let safeData = data {
                do {
                    let result = try JSONDecoder().decode(StockLogoData.self, from: safeData)
                    let stockURL = result.logo
                    delegate?.uploadPhotoURL(stockURL)
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func performInfoRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print(error!)
            }
            
            if let safeData = data {
                do {
                    let result = try JSONDecoder().decode(StockInfoData.self, from: safeData)
                    let currentPrice = result.c
                    let priceChange = result.d
                    delegate?.uploadCurrentPrice(currentPrice)
                    delegate?.uploadPriceChange(priceChange)
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }
        task.resume()
    }
}
