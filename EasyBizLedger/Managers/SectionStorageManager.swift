//
//  StorageManager.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/31.
//

import CoreData

typealias LSCategoryResults = (Result<[LSCategory]>) -> Void
typealias LSCategoryResult = (Result<LSCategory>) -> Void

@objc class SectionStorageManager: NSObject {
 
    static let shared = SectionStorageManager()
    
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

    func fetchCategoryNames(completion: LSCategoryResults = { _ in }) {
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
            fetchCategoryNames(completion: { result in
                switch result {
                case .success: completion(Result.success(()))
                case .failure(let error): completion(Result.failure(error))
                }
            })
        } catch {
            completion(Result.failure(error))
        }
    }

}

// MARK: - Data Operation
private extension LSCategory {

//    func mapping(_ object: Product) {
//        detail = object.description
//        id = object.id.int64()
//        images = object.images
//        mainImage = object.mainImage
//        note = object.note
//        place = object.note
//        price = object.price.int64()
//        sizes = object.sizes
//        story = object.story
//        texture = object.texture
//        title = object.title
//        wash = object.wash
//        colors = NSSet(array:
//            object.colors.map { color in
//                let lsColor = LSColor(context: StorageManager.shared.viewContext)
//                lsColor.mapping(color)
//                return lsColor
//            }
//        )
//        variants = NSSet(array:
//            object.variants.map { variant in
//                let lsVariant = LSVariant(context: StorageManager.shared.viewContext)
//                lsVariant.mapping(variant)
//                return lsVariant
//            }
//        )
//    }
}
