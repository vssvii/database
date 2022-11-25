//
//  CoreDataManager.swift
//  Navigation_2
//
//  Created by Developer on 15.11.2022.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init() {
        reloadPosts()
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        
    let container = NSPersistentContainer(name: "PostData")
        print(container.persistentStoreDescriptions.first?.url as Any)
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
    if let error = error as NSError? {
    fatalError("Unresolved error \(error), \(error.userInfo)")
    }
    })
    return container
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
    do {
    try context.save()
    } catch {
    let nserror = error as NSError
    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
    }
    }
    
    var posts: [PostData] = []
    
    func reloadPosts() {
        let request = PostData.fetchRequest()
        
        let posts = (try? persistentContainer.viewContext.fetch(request)) ?? []
        self.posts = posts
        
    }
    
        func addNewPost(author: String, description: String) {
            let post = PostData(context: persistentContainer.viewContext)
            post.author = author
            post.descript = description
            saveContext()
            reloadPosts()
        }
    
    func deletePosts(post: PostData) {
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadPosts()
    }
    
    func deleteAll() {
        
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }
        
        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator

             do {
                 try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
                 try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
             } catch {
                 print("Attempted to clear persistent store: " + error.localizedDescription)
             }
    }
}
