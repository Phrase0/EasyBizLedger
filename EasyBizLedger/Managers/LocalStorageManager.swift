//
//  StorageManager.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/31.
//

import CoreData

typealias LSCategoryResults = (Result<[LSCategory]>) -> Void
typealias LSCategoryResult = (Result<LSCategory>) -> Void

@objc class LocalStorageManager: NSObject {
    
    static let shared = LocalStorageManager()
    
    private enum Entity: String, CaseIterable {
        case LSCategory
        case LSItem
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
    
    @objc dynamic var categorys: [LSCategory] = []
    
    func fetchCategorys(completion: LSCategoryResults = { _ in }) {
        let request = NSFetchRequest<LSCategory>(entityName: Entity.LSCategory.rawValue)
        do {
            let categorys = try viewContext.fetch(request)
            self.categorys = categorys
            completion(Result.success(categorys))
        } catch {
            completion(Result.failure(error))
        }
    }
    
    func saveCategory(title: String, completion: (Result<Void>) -> Void) {
        let lsCategory = LSCategory(context: viewContext)
        lsCategory.title = title
        
        save(completion: completion)
    }
    
    func save(completion: (Result<Void>) -> Void = { _ in  }) {
        do {
            try viewContext.save()
            fetchCategorys(completion: { result in
                switch result {
                case .success: completion(Result.success(()))
                case .failure(let error): completion(Result.failure(error))
                }
            })
        } catch {
            completion(Result.failure(error))
        }
    }
    
    func deleteCategory(_ category: LSCategory, completion: (Result<Void>) -> Void) {
        viewContext.delete(category)
        save(completion: completion)
    }
    
    func saveItem(itemName: String, price: Int64, amount: Int64, photoData: Data?, completion: @escaping (Result<Void>) -> Void) {
        let lsItem = LSItem(context: viewContext)
        lsItem.itemName = itemName
        lsItem.price = price
        lsItem.amount = amount
        lsItem.photo = photoData
        save(completion: completion)
    }


}

