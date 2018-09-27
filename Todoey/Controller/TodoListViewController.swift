//
//  ViewController.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 12/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController{
    
    
    
    
    let realm = try! Realm()
    
    var todoItems : Results<Item>?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
  
 

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.separatorStyle = .none
        
        
        
    }
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
         title = selectedCategory?.name
        
        
         guard let colourHex = selectedCategory?.color else { fatalError()}
            
        
        updateNavBar(withHexCode: colourHex)
            
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        
        updateNavBar(withHexCode: "FF8AD8")
        
//        navigationController?.navigationBar.barTintColor = orignalColour
//
//        navigationController?.navigationBar.tintColor = FlatWhite()
//
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: FlatWhite()]
    }
    
    
    
    //Mark: - Nav BAr Setup Code
    
    func  updateNavBar(withHexCode colourHexCode: String)  {
        
        
         guard let navBar = navigationController?.navigationBar else{fatalError("Navigation Controller Does Not Exist")}
        
        guard let navBarColour = UIColor(hexString: colourHexCode) else {fatalError()}
        
        navBar.barTintColor = navBarColour
        
        navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
        
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColour, returnFlat: true)]
        
        searchBar.barTintColor = navBarColour
        
        
    }
    
    
    //Mark: - 2 tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
       
       let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] //if item is not nil then execute
        {
            
        cell.textLabel?.text = item.title
     
        cell.accessoryType = item.done ? .checkmark : .none
            
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: (CGFloat(indexPath.row) / CGFloat(todoItems!.count)) ){
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            
        }
        else {
            cell.textLabel?.text = "No Items Added"
        }
        
        cell.backgroundColor = UIColor.randomFlat
        
        return cell
    }

    
  
     //Mark: - 3 Table View Delegate Methods// Update in Realm
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        //Mark: - Updating Done Status Data Method
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    
                    //realm.delete(item) // to delete Item
                    
                    item.done = !item.done
                }
            }catch {
                print("Error Updating Done Status of selected item, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       }
    
    
    
    
    //Mark: Delete data from Swipe
    
    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)// print statement in superclass will not be shown without super keyword as we are overriding the func in superclass
        
        if let itemForDeletion = self.todoItems?[indexPath.row]{
            
            do{
                try realm.write {
                    print("deleted from sub class")
                    realm.delete(itemForDeletion) // to delete Item
                    
                }
            }catch {
                print("Error Deleting item, \(error)")
            }
            
        }
        
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
                    newItem.dateCreated = Date()
                    
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


extension TodoListViewController: UISearchBarDelegate {



    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {//delegate method
        
//        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        
         todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)        //Sorts Filtered in ascending order of date of creation
        
        tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()//deselects searchbar so that keyboard goes away
            }//DispatchQueue assigns processes to different threads so that app does not freeze while background process is running. i.e it brings this into foreground

        }
    }


}

