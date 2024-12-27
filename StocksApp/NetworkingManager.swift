//
//  NetworkingManager.swift
//  StocksApp
//
//  Created by Asset on 12/11/24.
//

import Foundation

struct NetworkingManager {
    
    let apiKey = "ctctrrpr01qlc0uvjqq0ctctrrpr01qlc0uvjqqg"

    // Fetch stock logo
    func fetchStockLogo(_ ticker: String, completion: @escaping (Result<(String, String), Error>) -> Void) {
        let urlString = "https://finnhub.io/api/v1/stock/profile2?symbol=\(ticker)&token=\(apiKey)"
        performLogoRequest(with: urlString, completion: completion)
    }
    
    // Fetch stock info
    func fetchStockInfo(_ ticker: String, completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        let urlString = "https://finnhub.io/api/v1/quote?symbol=\(ticker)&token=\(apiKey)"
        performInfoRequest(with: urlString, completion: completion)
    }
    
    // Perform logo request
    private func performLogoRequest(with urlString: String, completion: @escaping (Result<(String, String), Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(NetworkingError.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(StockLogoData.self, from: safeData)
                completion(.success((result.name, result.logo)))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // Perform info request
    private func performInfoRequest(with urlString: String, completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(NetworkingError.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(StockInfoData.self, from: safeData)
                completion(.success((result.c, result.d))) // Current price and price change
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkingError: Error {
    case invalidURL
    case noData
}
