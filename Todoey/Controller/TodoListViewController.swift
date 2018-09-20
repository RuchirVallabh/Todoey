//
//  ViewController.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 12/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    
    
    
    
    let realm = try! Realm()
    
    var todoItems : Results<Item>?
    
    
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
  
 

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    
    
    
    
    
    
    //Mark: - 2 tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
      
        
        if let item = todoItems?[indexPath.row] //if item is not nil then execute
        {
            
        cell.textLabel?.text = item.title
     
        cell.accessoryType = item.done ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }

    
  
     //Mark: - 3 Table View Delegate Methods// Update in Realm
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//        saveItems()
//   Different way of udating in realm
     
        tableView.deselectRow(at: indexPath, animated: true)
        
       }
    
    
    
    //Mark: - 4 add BarButton to add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            print("new Todoey Item Added")
            
            
            
            
  
            // Mark: Realm ADD ITEM / CREATE
            //Very Important : Understand This
            if let currentCategory = self.selectedCategory {
          
                do{
                try self.realm.write {
                    let  newItem = Item()
                    
                    newItem.title = textField.text!
                    //newItem.done = false// Already Selected as Default
                    currentCategory.items.append(newItem)
                                }
                 }catch {
                    print("Error Saving New Items, \(error)")
                        }
                
            }
            
            self.tableView.reloadData()
            
        }//closure
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create item"
            textField = alertTextField
            
            print(alertTextField.text ?? "see addTextField closure")
                           }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
          
    
    
    
           //MARK:   Data Load
 
    func loadItems()
    {
        
       todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

       tableView.reloadData()
   
    }

    
    
   
}






//MARK: - Search Bar method


//extension TodoListViewController: UISearchBarDelegate {
//
//
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {//delegate method
//
//        let request : NSFetchRequest<Item>  = Item.fetchRequest()
//
//       let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        //print(searchBar.text!)
//
//
////        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
////        request.sortDescriptors = [sortDescriptor]  //make sure its sortDescriptors i.e plural
//        //                       ↓
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
////        do{
////            itemArray = try context.fetch(request)
////        }catch{
////            print("error fetching data from context using searchBar \(error)")
////        }
////        tableView.reloadData()
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()//deselects searchbar so that keyboard goes away
//            }//DispatchQueue assigns processes to different threads so that app does not freeze while background process is running. i.e it brings this into foreground
//
//        }
//    }
//
//
//}
//
