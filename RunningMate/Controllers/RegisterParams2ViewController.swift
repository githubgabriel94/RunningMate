//
//  RegisterParams2ViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/29/21.
//

import UIKit
import Firebase

class RegisterParams2ViewController: UIViewController {
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var pBarWinds: UIProgressView!
    @IBOutlet weak var maxWindTextField: UITextField!
    @IBOutlet weak var maxChancePreTextField: UITextField!
    
    
    var maxWind = "MaxWind"
    var maxPrec = "MaxChanceOfPreci"
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        if let max = maxWindTextField.text, let maxChance = maxChancePreTextField.text, let documentName = Auth.auth().currentUser?.email{
            db.collection("Users").document(documentName).updateData([maxWind:max, maxPrec:maxChance]){
                (error) in
                if let e = error{
                    print("There was an issue saving data to firestore, \(e)")
                }else{
                    print("Successfully saved data.")
                    self.performSegue(withIdentifier: "params2ToParams3", sender: self)
                }
            }
        }
    }
}
