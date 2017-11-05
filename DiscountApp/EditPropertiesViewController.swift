//
//  EditPropertiesViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
import CoreImage
import UIKit
class EditPropertiesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var card = CardManager()
    var imageIs = ""
    var cardEdit:Card?
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var frontImage: UIImageView?
    @IBOutlet weak var backImage: UIImageView?
    @IBOutlet weak var barCodeImage: UIImageView!
    @IBOutlet weak var barCodeText: UITextField!
    @IBOutlet weak var cardDescription: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.frontImage?.isUserInteractionEnabled = true
        self.backImage?.isUserInteractionEnabled = true
        
        
        if let cardChange = cardEdit {
            self.cardName.text = cardChange.cardName
            self.cardDescription.text = cardChange.cardDescription
            self.frontImage?.image = loadImageFromPath(path: cardChange.cardFrontImage!, dates: cardChange.cardDate)
        }
        
    }
    
    @IBAction func generateBarCode(_ sender: Any) {
        barCodeImage.image = generateBarcode(from: barCodeText.text!)
    }
    
    @IBAction func createCard(_ sender: Any) {
        
        if  cardName.text != "" && cardDescription.text != "" && frontImage != nil {
            let newCard = Card(context:card.getContext())
            newCard.cardName = cardName.text!
            newCard.cardDescription = cardDescription.text!
            // newCard.setValue(Date(), forKey: "cardDate")
            newCard.cardDate = Date() as Date
            newCard.cardFrontImage = addToUrl((frontImage?.image)!)
            card.saveData()
        }   else {
            let alertController = UIAlertController(title: "OOPS", message: "You need to give all the informations required to save this card", preferredStyle: .alert)
            
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

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if barCodeText.text != nil && barCodeText.text != "" {
            if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                if let output = filter.outputImage?.transformed(by: transform) {
                    return UIImage(ciImage: output)
                }
            }
        }else{
            let alertController = UIAlertController(title: "Error", message: "You need to write text for generate barcode", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
        return nil
    }
   
    
}
