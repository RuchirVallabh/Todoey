//
//  AppDelegate.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 12/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import UIKit

import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)//Location of realm file



        do{  // Still Keeping it here to Catch any errors in case of a fresh initialization
            _ = try Realm()  //replacing realm with _

        }catch {
            print("Error Initializing New Realm, \(error)")
        }
        
        
        return true
  
    }

    
    

 

    
    
    
    
  

}

