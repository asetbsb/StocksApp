import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "StockItem")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save Core Data: \(error)")
            }
        }
    }

    // MARK: - Stock Favorites Management
    func fetchStocks() -> [String: Bool] {
        let fetchRequest: NSFetchRequest<StockItem> = StockItem.fetchRequest()
        do {
            let stocks = try context.fetch(fetchRequest)
            var stockDict = [String: Bool]()
            for stock in stocks {
                if let ticker = stock.ticker {
                    stockDict[ticker] = stock.isFavorite
                }
            }
            return stockDict
        } catch {
            print("Failed to fetch stocks: \(error)")
            return [:]
        }
    }

    func saveStock(ticker: String, isFavorite: Bool) {
        let fetchRequest: NSFetchRequest<StockItem> = StockItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ticker == %@", ticker)

        do {
            let results = try context.fetch(fetchRequest)
            if let stock = results.first {
                stock.isFavorite = isFavorite
            } else {
                let newStock = StockItem(context: context)
                newStock.ticker = ticker
                newStock.isFavorite = isFavorite
            }
            saveContext()
        } catch {
            print("Failed to save stock: \(error)")
        }
    }

    // MARK: - Search History Management
    func saveSearchQuery(_ query: String) {
        let fetchRequest: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "query == %@", query) 

        do {
            let results = try context.fetch(fetchRequest)
            if let existingSearch = results.first {
                existingSearch.timestamp = Date()
            } else {
                let newSearch = SearchRequest(context: context)
                newSearch.query = query
                newSearch.timestamp = Date()
            }
            saveContext()
        } catch {
            print("Error saving search query: \(error)")
        }
    }
    
    func fetchSearchHistory() -> [String] {
        let request: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        request.fetchLimit = 10
        
        do {
            return try context.fetch(request).compactMap { $0.query }
        } catch {
            print("Error fetching search history: \(error)")
            return []
        }
    }
}
