//
//  FavoriteButtonState.swift
//  StocksApp
//
//  Created by Asset on 1/20/25.
//

import Foundation
import UIKit

enum FavoriteState {
    case favorite
    case notFavorite
    
    var color: UIColor {
        switch self {
        case .favorite:
            return AppColors.favoriteColor.color
        case .notFavorite:
            return AppColors.notFavoriteColor.color
        }
    }
}
