//
//  MainViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
//import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
      
      var card = CardManager()
    
    @IBOutlet weak var prototypeTableView: UITableView!

    var  cardArray: [Card] = []
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = prototypeTableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! TableViewCell
        let card = cardArray[indexPath.row]
        cell.name?.text = card.cardName
        cell.cardDescription?.text = card.cardDescription
        cell.date.text = String(describing: card.cardDate!)
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO:
        }
        editAction.backgroundColor = .blue

        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (rowAction, indexPath) in
            //TODO:
        }
        shareAction.backgroundColor = .green

        let deleteAction = UITableViewRowAction(style: .normal , title: "Delete") { (rowAction, indexPath) in
            let cardID = self.cardArray[indexPath.row]
            self.card.getContext().delete(cardID)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                self.cardArray = try self.card.getContext().fetch(Card.fetchRequest())
            } catch{
                print(error)
            }
            self.prototypeTableView.reloadData()
        }
        deleteAction.backgroundColor = .red

        return [editAction, shareAction, deleteAction]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.prototypeTableView.reloadData()
        prototypeTableView.delegate = self
        prototypeTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Edit":
                _ = segue.destination as? MainViewController
                //            case "Cancel Edit" :
            //                let seguedToTableV = segue.destination as? TableViewController
            default :  break
                
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
        
    }
    
    func fetchData() {
        let context = card.getContext()
        
        do{
            cardArray = try context.fetch(Card.fetchRequest())
        } catch {
            print("Error fetch")
        }
        
    }
    
        
    
    
    
    
    
}
