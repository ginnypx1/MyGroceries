//
//  AppDelegate.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/17/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties

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
        
        // Create grocery lists
        let costcoList = GroceryList(name: "Costco List", context: stack.context)
        let vonsList  = GroceryList(name: "Vons List", context: stack.context)
        
        // Check out the "data" field when you print an NSManagedObject subclass.
        print(costcoList)
        print(vonsList)
        
        // Create Notes
        let bananas = Item(name: "Bananas", context: stack.context)
        let yogurt = Item(name: "Yogurt", context: stack.context)
        let salmon = Item(name: "Salmon", context: stack.context)
        
        // Let's set the grocery List property of those 3 notes
        bananas.groceryList = vonsList
        yogurt.groceryList = vonsList
        salmon.groceryList = costcoList

    }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        preloadData()
        return true
    }



}

