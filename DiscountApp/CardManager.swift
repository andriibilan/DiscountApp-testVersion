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
        do {
            try getContext().save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData(filter: String?) -> [Card]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName :"Card")
        if filter != nil && filter != "" {
            fetchRequest.predicate = NSPredicate(format: "filter == %@", filter!)
            var cardArray:[Card] = []
            
            do{
                cardArray = (try getContext().fetch(Card.fetchRequest()) as? [Card])!
            } catch {
                print("Error fetch")
            }
            return cardArray
        } else {
            do {
                var cardArray: [Card] = []
                cardArray = try getContext().fetch(Card.fetchRequest()) as! [Card]
                return cardArray
            } catch {
                let cardArray: [Card] = []
                return cardArray
            }
            
        }
        
        
    }
    
}







