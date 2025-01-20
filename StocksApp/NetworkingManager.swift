//
//  NetworkingManager.swift
//  StocksApp
//
//  Created by Asset on 12/11/24.

import Foundation

struct NetworkingManager {
    
    let apiKey = "ctctrrpr01qlc0uvjqq0ctctrrpr01qlc0uvjqqg"
    
    func fetchData<T>(type: FetchType, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Codable 
    {
        switch type {
        case .logoName(let ticker):
            let urlString = type.urlString + "\(apiKey)"
            requestData(urlString: urlString, responseType: responseType, completion: completion)

        case .prices(let ticker):
            let urlString = type.urlString + "\(apiKey)"
            requestData(urlString: urlString, responseType: responseType, completion: completion)
        }
    }
    
    func requestData<T: Codable>(urlString: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
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
