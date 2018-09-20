//
//  ViewController.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 12/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            // loadItems()//calling without parameter
        }
    }
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext//accessing property of appdelegate as an object

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") as Any)
//
        
      
      
       
        
        
    }
    
    
    
    
    //Mark: - 2 tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
      
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
     
        cell.accessoryType = item.done ? .checkmark : .none // Ternary Operator
        
        return cell
    }

    
  
     //Mark: - 3 Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
     
        tableView.deselectRow(at: indexPath, animated: true)
        
       }
    
    
    
    //Mark: - 4 add BarButton to add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            print("new Todoey Item Added")
            
            
            
            
            // Mark: Core Data ADD ITEM / CREATE
            
            
//            let  newItem = Item(context: self.context)
//
//
//            newItem.title = textField.text!
//            newItem.done = false// As done property of item entity is not optional
//            newItem.parentCategory = self.selectedCategory
//
//            self.itemArray.append(newItem)
//
            self.saveItems()
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create item"
            textField = alertTextField
            
            print(alertTextField.text ?? "see addTextField closure")
                           }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //Mark: Model Manipulation Methods
    
    
    
    func saveItems() {
      
        
        do {
            
            try context.save()
        }
        catch{
             print("error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
           //MARK:   Data Load
    
    
//    func loadItems() {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        do{
//            itemArray = try context.fetch(request)
//        }catch{
//            print("error fetching data from context \(error)")
//            }
//         }
    
              //       Changed to
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil)//giving default value
//    {
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates:  [categoryPredicate, predicate])
////
////
////        request.predicate = compoundPredicate
//
//        if let addtionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
//        }else{
//            request.predicate = categoryPredicate
//        }
//
//        do{
//            itemArray = try context.fetch(request)
//        }catch{
//            print("error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
//
//    }

    
    
   
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
