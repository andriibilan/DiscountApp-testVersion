//
//  MainViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
import Foundation
import UIKit
//import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {
    var filter: String = ""
      var card = CardManager()
   
    @IBOutlet weak var prototypeTableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar?
    
    var  cardArray: [Card] = []
    
    
    func filterForTableView(text: String){
        cardArray = cardArray.filter( { (mod)-> Bool in
            return (mod.cardName?.lowercased().contains(text.lowercased()))!
        })
        prototypeTableView?.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchName: String) {
        if searchName.isEmpty{
            cardArray = card.fetchData(filter: filter )
            prototypeTableView?.reloadData()
        } else {
            filterForTableView(text: searchName)
            prototypeTableView?.reloadData()
            
        }
    }
   
    func sortedCellFromPopover(_ identifierButton: String) {
        switch identifierButton {
        case "A ➞ Z":
            cardArray.sort() {  $0.cardName.lowercased() < $1.cardName.lowercased() }
            prototypeTableView?.reloadData()
        case "Z ➞ A":
            cardArray.sort() {  $0.cardName.lowercased() > $1.cardName.lowercased() }
           prototypeTableView?.reloadData()
            print(cardArray)
        default:
            break
        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArray.count
    } 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = prototypeTableView?.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! TableViewCell
        let card = cardArray[indexPath.row]
       // cell.clipsToBounds = true
        cell.name.text = card.cardName
       // print("card name : \(String(describing: card.cardName))")
        
        cell.cardDescription?.text = card.cardDescription
       // print("card descr : \(String(describing: card.cardDescription))")
        
        cell.date.text = DateFormatter.localizedString(from: (card.cardDate as Date?)!, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)

       cell.imagePrototype!.image = loadImageFromPath(path: card.cardFrontImage!, dates: card.cardDate! as Date )
      
//        if let cacheImage = imageCashe.object(forKey: card.cardName as AnyObject){
//            cell.imagePrototype.image = cacheImage as? UIImage
//        } else {
//             cell.imageURl = URL(string: card.cardFrontImage!)
//            self.imageCashe.setObject(URL(string: card.cardFrontImage!) as AnyObject, forKey: card.cardName as AnyObject)
//        }
        
      //  cell.imageURl = URL(string: card.cardFrontImage!)
        print("card foto : \(String(describing: URL(string: card.cardFrontImage!)))")
       
        return cell
    }

    func loadImageFromPath(path: String,dates: Date ) -> UIImage? {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let pathURL = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent("\(dates).jpg"))
         print("Download image to TBV")
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
            self.performSegue(withIdentifier: "Show Edit", sender: self.cardArray[indexPath.row])
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
            self.prototypeTableView?.reloadData()
        }
        deleteAction.backgroundColor = .red

        return [editAction, shareAction, deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    //    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//   //     let destination = storyboard.instantiateViewController(withIdentifier: "showPaging") as! UIPageViewController
//  //      navigationController?.pushViewController(destination, animated: true)
//
//        let destination = UIViewController() // Your destination
//       navigationController?.pushViewController(destination, animated: true)
//        performSegue(withIdentifier: "showPaging", sender: self)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.fetchData()
       cardArray = card.fetchData(filter: filter)
        self.prototypeTableView?.reloadData()
        prototypeTableView?.delegate = self
        prototypeTableView?.dataSource = self
        searchBar?.delegate = self
        //card.fetchData(filter: filter)
        // Do any additional setup after loading the view.
        
      
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Edit":
                let   goToEdit = segue.destination as? EditPropertiesViewController
                goToEdit?.cardEdit = sender as? Card
            case "showPopover" :
                let popoverViewController = segue.destination
                popoverViewController.popoverPresentationController?.delegate = self
                
            default :  break
                
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    
        
    
    
    
    
    
}



