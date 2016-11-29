//
//  CoreDataStack.swift
//  SurJournal
//
//  Created by Vladimir Nevinniy on 11/28/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import CoreData

class CoreDataStack {
    let seedName = "SurfJournalDatabase"
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SurJournal")
        
        //NSPersistentContainer(name: <#T##String#>, managedObjectModel: <#T##NSManagedObjectModel#>)
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let applicationDocumentsDirectory: URL = urls[urls.count-1]
        let url = applicationDocumentsDirectory.appendingPathComponent("\(self.seedName).sqlite")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                
                
                
                
               
                
                let bundle = Bundle.main
                
                //print(bundle)
                
                let seededDatabaseURL = bundle.url(forResource: self.seedName, withExtension: "sqlite")
                
               
                
                storeDescription.type = NSSQLiteStoreType
                storeDescription.url  = url
                
                print(url)
                print(storeDescription.url ?? "nill")
                
                let didCopyDatabase: Bool
                
                do {
                    try FileManager.default.copyItem(at: seededDatabaseURL!, to: url)
                    didCopyDatabase = true
                } catch let error {
                    didCopyDatabase = false
                }
                
                if didCopyDatabase {
                    let seededSHMURL = bundle.url(forResource: self.seedName, withExtension: "sqlite-shm")
                    let shmURL = applicationDocumentsDirectory.appendingPathComponent("\(self.seedName).sqlite-shm")
                    
                    do {
                        try FileManager.default.copyItem(at: seededSHMURL!, to: shmURL)
                    } catch  {
                        print(error)
                        abort()
                    }
                    
                    
                    let seededWALURL = bundle.url(forResource: self.seedName, withExtension: "sqlite-wal")
                    let walURL = applicationDocumentsDirectory.appendingPathComponent("\(self.seedName).sqlite-wal")
                    
                    do {
                        try FileManager.default.copyItem(at: seededWALURL!, to: walURL)
                    } catch  {
                        print(error)
                        abort()
                    }
                    
                }
                
                
                
            }
        })
        
        print(container.persistentStoreDescriptions[0])
        
        container.persistentStoreDescriptions[0].url = url
        container.persistentStoreDescriptions[0].type = NSSQLiteStoreType
        print(container.persistentStoreDescriptions[0])
        
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
