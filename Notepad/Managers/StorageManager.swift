//
//  StorageManager.swift
//  Notepad
//
//  Created by Konstantin Losev on 08.11.2022.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notepad")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    //    MARK: - Data Methods
    
    func fetchData() -> [Note] {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error)
            return []
        }
    }
    
    func saveData(_ noteName: String, completion: (Note) -> Void) {
        guard let entity = NSEntityDescription.entity(
            forEntityName: "Note",
            in: persistentContainer.viewContext
        ) else { return }
        
        let note = NSManagedObject(entity: entity, insertInto: viewContext) as! Note
        note.name = noteName
        
        completion(note)
        saveContext()
    }
    
    func edit(_ note: Note, newNote: String) {
        note.name = newNote
        saveContext()
    }
    
    func delete(_ note: Note) {
        viewContext.delete(note)
        saveContext()
    }

    // MARK: - Core Data Saving support
    
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
