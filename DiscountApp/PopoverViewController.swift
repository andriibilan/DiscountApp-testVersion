//
//  PopoverViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/5/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class PopoverViewController: MainViewController{
   var chooseButton: String = ""
   
    @IBAction func sortFromAtoZ(_ sender: Any) {
       chooseButton = "A ➞ Z"
         dismiss(animated: true, completion: nil)
        sortedCellFromPopover( chooseButton)
        prototypeTableView?.reloadData()
        print("touch button")
    }
    
    @IBAction func sortFromZtoA(_ sender: Any) {
        chooseButton = "Z ➞ A"
        sortedCellFromPopover(chooseButton)
          prototypeTableView?.reloadData()
   dismiss(animated: true, completion: nil)
    }

    @IBAction func dateUp(_ sender: Any) {
       // cardArray.sort() { $0.cardDate < $1.cardDate }
       // self.prototypeTableView.reloadData()
    }
    
    @IBAction func dateDown(_ sender: Any) {
        //cardArray.sort() { $0.cardDate > $1.cardDate }
       //self.prototypeTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
