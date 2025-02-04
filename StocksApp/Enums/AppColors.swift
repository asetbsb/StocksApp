//
//  ApplicationColors.swift
//  StocksApp
//
//  Created by Asset on 1/23/25.
//

import Foundation

import UIKit

enum AppColors {
    case favoriteColor
    case notFavoriteColor
    case greenPriceColor
    case redPriceColor
    case greyColor
    
    var color: UIColor {
        switch self {
        case .favoriteColor:
            return UIColor(rgb: 0xFFCA1C)
        case . notFavoriteColor:
            return UIColor(rgb: 0xBABABA)
        case .greenPriceColor:
            return UIColor(rgb: 0x24B25D)
        case .redPriceColor:
            return UIColor(rgb: 0xB22424)
        case .greyColor:
            return UIColor(rgb: 0xF0F4F7)
        }
    }
}
