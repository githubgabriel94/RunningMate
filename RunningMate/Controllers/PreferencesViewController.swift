//
//  PreferencesViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 6/2/21.
//

import UIKit
import Firebase

class PreferencesViewController : UIViewController {
    
    var db = Firestore.firestore()
    
    var name = "Name"
    var lastName = "LastName"
    var address = "Address"
    var city = "City"
    var zip = "ZipCode"
    var phone = "PhoneNumber"
    var weight = "Weight(Kg)"
    var maxTemp = "MaximunTemp"
    var minTemp = "MinimunTemp"
    var maxWind = "MaxWind"
    var maxChance = "MaxChanceOfPreci"
    var search = "searchRadius"
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var maxTempField: UITextField!
    @IBOutlet weak var minTempField: UITextField!
    @IBOutlet weak var maxWindField: UITextField!
    @IBOutlet weak var maxChanceField: UITextField!
    @IBOutlet weak var searchField: UITextField!
    
    

    @IBAction func deleteAccountButton(_ sender: UIButton) {
        
        if let documentName = Auth.auth().currentUser?.email{
            db.collection("Users").document(documentName).delete(){
                (error) in
                if error != nil{
                    let alertController = UIAlertController(title: "Error", message: "There was an error deleting your account", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let user = Auth.auth().currentUser
                    
                    user?.delete {
                        (error) in
                        if error != nil {
                            let alertController = UIAlertController(title: "Error", message: "There was an error deleting your account", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                            self.present(alertController, animated: true, completion: nil)
                        }else{
                            let alertController = UIAlertController(title: "Success", message: "Your account was succesfully deleted from our database along with all your information", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in 
                                self.navigationController?.popToRootViewController(animated: true)
                            }))
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func updatePreferences(_ sender: UIButton) {
        
        if let documentName = Auth.auth().currentUser?.email{
            db.collection("Users").document(documentName).updateData([name: nameField.text!, lastName: lastNameField.text!, address: addressField.text!, city: cityField.text!, zip: zipField.text!, phone: phoneField.text!, weight: weightField.text!, maxTemp: maxTempField.text!, minTemp: minTempField.text!, maxWind: maxWindField.text!, maxChance: maxChanceField.text!, search: searchField.text!]){
                (error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: "There was an error updating your information", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "Success", message: "Your information updated succesfully", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let documentName = Auth.auth().currentUser?.email{
            let docRef = db.collection("Users").document(documentName)
            
            docRef.getDocument{ (document, error) in
                if let document = document, document.exists{
                    
                    let userName = document.get("Name")
                    self.nameField.text = userName as? String
                    
                    let lastName = document.get("LastName")
                    self.lastNameField.text = lastName as? String
                    
                    let address = document.get("Address")
                    self.addressField.text = address as? String
                    
                    let city = document.get("City")
                    self.cityField.text = city as? String
                    
                    let zip = document.get("ZipCode")
                    self.zipField.text = zip as? String
                    
                    let phone = document.get("PhoneNumber")
                    self.phoneField.text = phone as? String
                    
                    let weight = document.get("Weight(Kg)")
                    self.weightField.text = weight as? String
                    
                    let maxTemp = document.get("MaximunTemp")
                    self.maxTempField.text = maxTemp as? String
                    
                    let minTemp = document.get("MinimunTemp")
                    self.minTempField.text = minTemp as? String
                    
                    let maxWind = document.get("MaxWind")
                    self.maxWindField.text = maxWind as? String
                    
                    let maxChance = document.get("MaxChanceOfPreci")
                    self.maxChanceField.text = maxChance as? String
                    
                    let search = document.get("searchRadius")
                    self.searchField.text = search as? String
                }
            }
        }
    }
    
}
