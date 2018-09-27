//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 24/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import UIKit
import SwipeCellKit


class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
 

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         tableView.rowHeight = 80.0
        
    }

    
    
    //TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell//Swipe Cell Addition
        
        
        
           cell.delegate = self//Swipe cell addition
        
        
        return cell
        
    }
    
    
    // delegate method
    
    
    
    //MARK: - Swipe Celle Delegate methods
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
      
            
            print("Delete Cell")
            // handle action by updating model with deletion
            
            self.updateModel(at: indexPath)
            
          
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    
    
    
    func updateModel(at indexPath: IndexPath)  {
    
        //Update The Data here
        print("Item Deleted from SuperClass")
        
    }
    
    
    
}


