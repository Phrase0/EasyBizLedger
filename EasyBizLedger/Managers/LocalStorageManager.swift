//
//  StorageManager.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/31.
//

import UIKit
import CoreData

typealias LSLedgerResult = (Result<LSLedger>) -> Void
typealias LSCategoryResult = (Result<LSCategory>) -> Void
typealias LSItemResult = (Result<LSItem>) -> Void

typealias LSLedgerResults = (Result<[LSLedger]>) -> Void
typealias LSCategoryResults = (Result<[LSCategory]>) -> Void
typealias LSItemResults = (Result<[LSItem]>) -> Void

@objc class LocalStorageManager: NSObject {
    
    static let shared = LocalStorageManager()
    
    private enum Entity: String, CaseIterable {
        case ledger = "LSLedger"
        case category = "LSCategory"
        case item = "LSItem"
    }
    
    private override init() {
        print(" Core data file path: \(NSPersistentContainer.defaultDirectoryURL())")
    }
    
    // MARK: - Core Data stack
    lazy var persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EasyBizLedger")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistanceContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    @objc dynamic var ledgers: [LSLedger] = []
    @objc dynamic var categorys: [LSCategory] = []
    @objc dynamic var items: [LSItem] = []
    
    // MARK: - fetch methods
    func fetchLedgers(completion: LSLedgerResults = { _ in }) {
        let request = NSFetchRequest<LSLedger>(entityName: Entity.ledger.rawValue)
        request.sortDescriptors = [NSSortDescriptor(key: "createTime", ascending: true)]
        do {
            let ledgers = try viewContext.fetch(request)
            self.ledgers = ledgers
            completion(Result.success(ledgers))
        } catch {
            completion(Result.failure(error))
        }
    }
    
    func fetchCategories(forLedger ledger: LSLedger, completion: LSCategoryResults = { _ in }) {
        guard let ledgerTitle = ledger.ledgerTitle else {
            completion(Result.failure(NSError(domain: "LocalStorageManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Ledger title is nil"])))
            return
        }
        
        let request = NSFetchRequest<LSCategory>(entityName: Entity.category.rawValue)
        request.predicate = NSPredicate(format: "ledger.ledgerTitle == %@", ledgerTitle)
        request.sortDescriptors = [NSSortDescriptor(key: "createTime", ascending: true)]
        do {
            let categories = try viewContext.fetch(request)
            self.categorys = categories
            completion(Result.success(categories))
        } catch {
            completion(Result.failure(error))
        }
    }
    
    func fetchItems(forCategory category: LSCategory, completion: LSItemResults = { _ in }) {
        guard let categoryTitle = category.title else {
            completion(Result.failure(NSError(domain: "LocalStorageManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Category title is nil"])))
            return
        }
        
        let request = NSFetchRequest<LSItem>(entityName: Entity.item.rawValue)
        request.predicate = NSPredicate(format: "category.title == %@", categoryTitle)
        request.sortDescriptors = [NSSortDescriptor(key: "createTime", ascending: true)]
        do {
            let items = try viewContext.fetch(request)
            self.items = items
            completion(Result.success(items))
        } catch {
            completion(Result.failure(error))
        }
    }
    
    // MARK: - Save Methods
    func saveLedger(ledgerTitle: String, completion: @escaping (Result<Void>) -> Void) {
        let ledger = LSLedger(context: viewContext)
        ledger.ledgerTitle = ledgerTitle
        save(completion: completion)
    }
    
    func saveCategory(title: String, inLedger ledger: LSLedger, completion: @escaping (Result<Void>) -> Void) {
        let category = LSCategory(context: viewContext)
        category.title = title
        category.ledger = ledger
        
        save(completion: completion)
    }
    
    func saveItem(itemName: String, price: Int, amount: Int, photoData: UIImage?, inCategory category: LSCategory, completion: @escaping (Result<Void>) -> Void) {
        let lsItem = LSItem(context: viewContext)
        lsItem.itemName = itemName
        lsItem.price = Int64(price)
        lsItem.amount = Int64(amount)
        // Convert UIImage to Data
        if let image = photoData, let imageData = image.pngData() {
            lsItem.photo = imageData
        }
        save(completion: completion)
    }
    
    // MARK: - Delete Methods
    func deleteLedger(_ ledger: LSLedger, completion: (Result<Void>) -> Void) {
        viewContext.delete(ledger)
        save(completion: completion)
    }
    
    func deleteCategory(_ category: LSCategory, completion: (Result<Void>) -> Void) {
        viewContext.delete(category)
        save(completion: completion)
    }
    
    func deleteItem(_ item: LSItem, completion: (Result<Void>) -> Void) {
        viewContext.delete(item)
        save(completion: completion)
    }
    
    func save(completion: (Result<Void>) -> Void = { _ in }) {
        do {
            try viewContext.save()
            completion(Result.success(()))
        } catch {
            completion(Result.failure(error))
        }
    }
    // ---------------------------------------------------
    //    func fetchCategorys(completion: LSCategoryResults = { _ in }) {
    //        let request = NSFetchRequest<LSCategory>(entityName: Entity.LSCategory.rawValue)
    //        // Fetch the related items
    //        request.relationshipKeyPathsForPrefetching = ["items"]
    //
    //        do {
    //            let categorys = try viewContext.fetch(request)
    //            self.categorys = categorys
    //            completion(Result.success(categorys))
    //        } catch {
    //            completion(Result.failure(error))
    //        }
    //    }
    // ---------------------------------------------------
    //    func saveCategory(title: String, completion: (Result<Void>) -> Void) {
    //        let lsCategory = LSCategory(context: viewContext)
    //        lsCategory.title = title
    //
    //        save(completion: completion)
    //    }
    //
    //    func save(completion: (Result<Void>) -> Void = { _ in  }) {
    //        do {
    //            try viewContext.save()
    //            fetchCategorys(completion: { result in
    //                switch result {
    //                case .success: completion(Result.success(()))
    //                case .failure(let error): completion(Result.failure(error))
    //                }
    //            })
    //        } catch {
    //            completion(Result.failure(error))
    //        }
    //    }
    //
    //    func deleteCategory(_ category: LSCategory, completion: (Result<Void>) -> Void) {
    //        viewContext.delete(category)
    //        save(completion: completion)
    //    }
    //
    //    func saveItem(itemName: String, price: Int, amount: Int, photoData: UIImage?, inCategory category: LSCategory, completion: @escaping (Result<Void>) -> Void) {
    //        let lsItem = LSItem(context: viewContext)
    //        lsItem.itemName = itemName
    //        lsItem.price = Int64(price)
    //        lsItem.amount = Int64(amount)
    //        // Convert UIImage to Data
    //        if let image = photoData, let imageData = image.pngData() {
    //            lsItem.photo = imageData
    //        }
    //        // Associate LSItem with LSCategory
    //        category.addToItems(lsItem)
    //        save(completion: completion)
    //    }
}
