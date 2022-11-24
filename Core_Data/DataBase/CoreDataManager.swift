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
    /*
    The persistent container for the application. This implementation
    creates and returns a container, having loaded the store for the
    application to it. This property is optional since there are legitimate
    error conditions that could cause the creation of the store to fail.
    */
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
    // Replace this implementation with code to handle the error appropriately.
    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
    
//    func addNewPost(author: String, description: String) {
//        let post = PostData(context: persistentContainer.viewContext)
//        post.author = author
//        post.descript = description
//        saveContext()
//        reloadPosts()
//    }
    
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
