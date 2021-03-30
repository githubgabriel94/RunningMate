//
//  RegisterUserInfoViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/29/21.
//

import UIKit
import Firebase

class RegisterUserInfoViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var UserID = "UserID"
    var Name = "Name"
    var LastName = "LastName"
    var Adress = "Address"
    var City = "City"
    var ZipCode = "ZipCode"
    var Gender = "Gender"
    var Weight = "Weight(Kg)"
    var Phone = "PhoneNumber"
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        if let name = nameTextField.text, let lastName = lastNameTextField.text, let address = adressTextField.text, let city = cityTextField.text, let zip = zipTextField.text, let gender = genderTextField.text, let weight = weightTextField.text, let phone = phoneTextField.text, let userId = Auth.auth().currentUser?.uid, let documentName = Auth.auth().currentUser?.email{
            db.collection("Users").document(documentName).setData([UserID: userId, Name: name, LastName: lastName, Adress: address, City: city, ZipCode: zip, Gender: gender, Weight: weight, Phone: phone]) { (error) in
                    if let e = error{
                        print("There was an issue saving data to firestore, \(e)")
                    } else{
                        print("Succesfully saved data.")
                        self.performSegue(withIdentifier: "userInfoToParams1", sender: self)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
}
