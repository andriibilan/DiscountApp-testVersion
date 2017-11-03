//
//  MainViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
//import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate {
    var filter: String = ""
      var card = CardManager()
    
    @IBOutlet weak var prototypeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var  cardArray: [Card] = []
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func filterForTableView(text: String){
        cardArray = cardArray.filter( { (mod)-> Bool in
            return (mod.cardName?.lowercased().contains(text.lowercased()))!
        })
        self.prototypeTableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchName: String) {
        if searchName.isEmpty{
            cardArray = card.fetchData(filter: filter )
            self.prototypeTableView.reloadData()
        } else {
            filterForTableView(text: searchName)
            self.prototypeTableView.reloadData()
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = prototypeTableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! TableViewCell
        let card = cardArray[indexPath.row]
       // cell.clipsToBounds = true
    
        cell.name?.text = card.cardName
       // print("card name : \(String(describing: card.cardName))")
        
        cell.cardDescription?.text = card.cardDescription
       // print("card descr : \(String(describing: card.cardDescription))")
        
        cell.date.text = DateFormatter.localizedString(from: (card.cardDate as Date?)!, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
        
        cell.imagePrototype!.image = loadImageFromPath(path: card.cardFrontImage!, dates: card.cardDate! as Date )
        
       // print("card foto : \(String(describing: card.cardFrontImage))")
        return cell
    }
    
    func loadImageFromPath(path: String,dates: Date ) -> UIImage? {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let pathURL = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent("\(dates).jpg"))
        do {
            let imageData = try Data(contentsOf: pathURL)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
   
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO:
            self.performSegue(withIdentifier: "Show Edit", sender: self)
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
                self.cardArray = try self.card.getContext().fetch(Card.fetchRequest()) as! [Card]
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
       // self.fetchData()
       cardArray = card.fetchData(filter: filter)
        self.prototypeTableView.reloadData()
        prototypeTableView.delegate = self
        prototypeTableView.dataSource = self
        searchBar.delegate = self
        //card.fetchData(filter: filter)
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
    
    
    

    
        
    
    
    
    
    
}

//class GlitchyModel
//{
//    func textForIndexPath(indexPath: NSIndexPath) -> String
//    {
//        Thread.sleep(forTimeInterval: 1)
//        return "\(indexPath.row)"
//    }
//}

