//
//  ItemsViewController.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/19/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import Foundation
import UIKit

class ItemsViewController: CoreDataTableViewController {
    
    // MARK: TableView Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the note
        let item = fetchedResultsController?.object(at: indexPath) as! Item
        
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        // Sync note -> cell
        cell.textLabel?.text = item.name
        
        // Return the cell
        return cell
    }
    
}
