//
//  AppDelegate.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/17/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit
import CoreData

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Properties
    
    var window: UIWindow?
    let stack = CoreDataStack(modelName: "Model")!
    
    // MARK: Preload Data
    
    func preloadData() {
        
        // Remove previous stuff (if any)
        do {
            try stack.dropAllData()
        } catch {
            print("Error droping all objects in DB")
        }
        
        // Create grocery list
        let vonsList = GroceryList(name: "Vons", context: stack.context)
        let costcoList  = GroceryList(name: "Costco", context: stack.context)
        
        // Check out the "data" field when you print an NSManagedObject subclass.
        print(vonsList)
        print(costcoList)
        
        // Create Items
        let bananas = Item(name: "Bananas", context: stack.context)
        let salmon = Item(name: "Salmon", context: stack.context)
        
        // Let's set the notebook property of those 2 notes
        bananas.groceryList = vonsList
        salmon.groceryList = costcoList

    }
    
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Load some notebooks and notes.
        // preloadData()
        // Start Autosaving
        stack.autoSave(10)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

        stack.save()
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

        stack.save()
    }
}


