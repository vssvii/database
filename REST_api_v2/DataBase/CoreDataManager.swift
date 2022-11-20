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
    let container = NSPersistentContainer(name: "Posts")
        print(container.persistentStoreDescriptions.first?.url)
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
    
    var posts: [Post] = []
    
    func reloadPosts() {
        let request = Post.fetchRequest()
        
        let posts = (try? persistentContainer.viewContext.fetch(request)) ?? []
        
        
    }
    
    func addNewPost(author: String, description: String, image: Data, likes: Int16, views: Int16) {
        let post = Post(context: persistentContainer.viewContext)
//        let imageObject = NSManagedObject(entity:, insertInto: )
//        imageObject.setValue(image, forKey: Constants.imageAttribute)
//        let entityPost =  NSEntityDescription.entity(forEntityName: , in: managedContext)!
//        let entityPost = NSEntityDescription.entity(forEntityName: "Post", in: mana)
//        let image = NSManagedObject(entity: entityName, insertInto: managedContext)
//        image.setValue(jpegData, forKeyPath: 'Your Attribute Name')
//        do {
//          try managedContext.save()
//        } catch let error as NSError {
//          print("Could not save. \(error), \(error.userInfo)")
//        }
        post.author = author
        post.descript = description
        post.image = image
        post.likes = likes
        post.views = views
//        post.descript = name
        saveContext()
        reloadPosts()
    }
    
    func deletePosts(post: Post) {
        persistentContainer.viewContext.delete(post)
    }
}
