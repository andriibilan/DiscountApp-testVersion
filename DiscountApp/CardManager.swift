//
//  CardManager.swift
//  DiscountApp
//
//  Created by andriibilan on 10/31/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
import CoreData
class CardManager: NSObject {
    
    func getContext() ->NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    func storeObj(){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)
        
        let  manageObj = NSManagedObject(entity: entity!, insertInto: context)
        
 
    }
    
    func saveData(){
        let context = getContext()
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    

    

}
