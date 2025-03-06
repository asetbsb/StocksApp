//
//  StockItem+CoreDataProperties.swift
//  StocksApp
//
//  Created by Asset on 3/6/25.
//
//

import Foundation
import CoreData


extension StockItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockItem> {
        return NSFetchRequest<StockItem>(entityName: "StockItem")
    }

    @NSManaged public var ticker: String?
    @NSManaged public var isFavorite: Bool

}

extension StockItem : Identifiable {

}
