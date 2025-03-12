//
//  SearchRequest+CoreDataProperties.swift
//  StocksApp
//
//  Created by Asset on 3/6/25.
//
//

import Foundation
import CoreData


extension SearchRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchRequest> {
        return NSFetchRequest<SearchRequest>(entityName: "SearchRequest")
    }

    @NSManaged public var query: String?
    @NSManaged public var timestamp: Date?

}

extension SearchRequest : Identifiable {

}
