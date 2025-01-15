//
//  NetworkingManager.swift
//  StocksApp
//
//  Created by Asset on 12/11/24.

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

enum NetworkingError: Error {
    case invalidURL
    case noData
}

struct NetworkingManager {
    
    let apiKey = "ctctrrpr01qlc0uvjqq0ctctrrpr01qlc0uvjqqg"
    
    func fetchData<T>(type: FetchType, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Codable 
    {
        switch type {
        case .logoName(let ticker):
            requestData(type: .logoName(ticker), responseType: responseType, completion: completion)

        case .prices(let ticker):
            requestData(type: .prices(ticker), responseType: responseType, completion: completion)
        }
    }
    
    func requestData<T: Codable>(type: FetchType, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = type.urlString + "\(apiKey)"
        
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
                let result = try JSONDecoder().decode(T.self, from: safeData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
