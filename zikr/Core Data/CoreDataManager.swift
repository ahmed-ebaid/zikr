import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private(set) var managedObjectContext: NSManagedObjectContext
    
    init() {
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing Managed Object Model from: \(modelURL)")
        }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    func insert(_ object: NSManagedObject) {
        managedObjectContext.insert(object)
    }
    
    func delete(_ object: NSManagedObject) {
        managedObjectContext.delete(object)        
    }
    
    func save() {
        do {
            if managedObjectContext.hasChanges {
                try managedObjectContext.save()
            }
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func fetch(forEntity entityName: String, sortDescriptor: NSSortDescriptor? = nil) -> [NSManagedObject] {
        let fetchedEntity = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if sortDescriptor != nil {
            fetchedEntity.sortDescriptors = [sortDescriptor!]
        }
        do {
            return try managedObjectContext.fetch(fetchedEntity) as! [NSManagedObject]
        } catch {
            fatalError("Failed to fetch managed objects for entity: \(entityName) and with error: \(error)")
        }
        return []
    }
}
