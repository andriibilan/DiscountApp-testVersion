//
//  EditPropertiesViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
class EditPropertiesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var card = CardManager()
    var imageIs = ""
    
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var frontImage: UIImageView?
    @IBOutlet weak var backImage: UIImageView?
    
    @IBOutlet weak var cardDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.frontImage?.isUserInteractionEnabled = true
        self.backImage?.isUserInteractionEnabled = true
        
    }
    @IBAction func createCard(_ sender: Any) {
        
        if  cardName.text != "" && cardDescription.text != "" && frontImage != nil {
            let newCard = Card(context:card.getContext())
            newCard.cardName = cardName.text!
            newCard.cardDescription = cardDescription.text!
            // newCard.setValue(Date(), forKey: "cardDate")
            newCard.cardDate = Date() as NSDate
            newCard.cardFrontImage = addToUrl((frontImage?.image)!)
            card.saveData()
        }   else {
            let alertController = UIAlertController(title: "OOPS", message: "You need to give all the informations required to save this product", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapToFrontImage(_ sender: Any) {
        imageIs = "frontImage"
        allertAfterTapRecognizer()
    }
    @IBAction func tapToBackImage(_ sender: Any) {
        imageIs = "backImage"
        allertAfterTapRecognizer()
    }
    
    func allertAfterTapRecognizer() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        if  imageIs == "frontImage" {
            self.frontImage?.image = image
        }else{
            self.backImage?.image = image
        }
    }
    
    
    func addToUrl (_ photo: UIImage )  -> String {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imgPath = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent("\(Date()).jpg"))// Change extension if you want to save as PNG
        let imageString = String(describing: imgPath)
        do{
            try UIImageJPEGRepresentation(photo, 1.0)?.write(to: imgPath, options: .atomic)
        }catch let error{
            print(error.localizedDescription)
        }
        return imageString
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    

}
