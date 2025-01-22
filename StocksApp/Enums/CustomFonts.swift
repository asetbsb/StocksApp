//
//  CustomFonts.swift
//  StocksApp
//
//  Created by Asset on 1/22/25.
//

import Foundation
import UIKit

enum CustomFonts {
    case bold
    case regular
    case semiBold
    
    var fontFamily: String {
        switch self {
        case .bold:
            return "Montserrat-Bold"
        case .regular:
            return "Montserrat-Regular"
        case .semiBold:
            return "Montserrat-SemiBold"
        }
    }
}
