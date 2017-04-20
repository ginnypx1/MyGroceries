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
        
        // Create Items
        let bananas = Item(name: "Bananas", context: stack.context)
        let salmon = Item(name: "Salmon", context: stack.context)
        
        // set the grocery list for the items
        bananas.groceryList = vonsList
        salmon.groceryList = costcoList

    }
    
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Load some grocery lists and items.
        // preloadData()
        stack.autoSave(10)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // save when the application is about to move from active to inactive state.
        do {
            try stack.saveContext()
        } catch {
            print("There was an error saving the app data in WillResignActive.")
        }
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // save when app moves to the background
        do {
            try stack.saveContext()
        } catch {
            print("There was an error saving the app data in WillResignActive.")
        }
    }
}


