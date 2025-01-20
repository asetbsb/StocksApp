//
//  FavoriteButtonState.swift
//  StocksApp
//
//  Created by Asset on 1/20/25.
//

import Foundation
import UIKit

enum StockFavoriteState {
    case favorite
    case notFavorite
    
    var color: UIColor {
        switch self {
        case .favorite:
            return .yellow
        case .notFavorite:
            return .lightGray
        }
    }
}
