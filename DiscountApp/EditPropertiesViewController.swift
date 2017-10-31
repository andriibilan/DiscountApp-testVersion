//
//  EditPropertiesViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class EditPropertiesViewController: UIViewController {
    
    var card = CardManager()
    
    
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var cardDescription: UITextField!
    
    
 
    
    
    
    @IBAction func createCard(_ sender: Any) {
        
        if (cardName?.text != "" || cardName?.text != nil) && (cardDescription?.text != "" || cardDescription?.text != nil){
            
            let newCard = Card(context:card.getContext())
            newCard.setValue(self.cardName.text!, forKey: "cardName")
            newCard.setValue(self.cardDescription.text!, forKey: "cardDescription")
            
            card.storeObj()

            
            
        } else {
            print("fill all field")
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    

}
