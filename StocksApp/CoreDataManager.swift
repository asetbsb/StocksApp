import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()

    private let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "StockItem")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }

    func fetchStocks() -> [String: Bool] {
        let fetchRequest: NSFetchRequest<StockItem> = StockItem.fetchRequest()
        do {
            let stocks = try context.fetch(fetchRequest)
            var stockDict = [String: Bool]()
            for stock in stocks {
                stockDict[stock.ticker ?? ""] = stock.isFavorite
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
}
