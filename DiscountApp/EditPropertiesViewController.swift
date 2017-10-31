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
        
//        if
//          cardName.text != "" && cardDescription.text != ""
//        {

            let newCard = Card(context:card.getContext())
            newCard.setValue(self.cardName.text!, forKey: "cardName")
            newCard.setValue(self.cardDescription.text!, forKey: "cardDescription")
            newCard.setValue(datetimer(), forKey: "cardDate")
            card.saveData()
//        }
//        else {
//            print("fill all field")
//        }

        
    }
    
    func datetimer() -> Date {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        let dateT = dateFormatter.date(from: dateString)
        return dateT!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    

}
