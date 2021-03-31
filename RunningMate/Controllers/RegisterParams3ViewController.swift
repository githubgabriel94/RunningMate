//
//  RegisterParams3ViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/29/21.
//

import UIKit
import Firebase

class RegisterParams3ViewController: UIViewController {
    
    var db = Firestore.firestore()
    
    @IBOutlet weak var pBarAverageSpeed: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var averageSpeedTextField: UITextField!
    
    var aveSpeed = "AverageSpeed"
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        if let averageSpeed = averageSpeedTextField.text, let documentName = Auth.auth().currentUser?.email{
            db.collection("Users").document(documentName).updateData([aveSpeed:averageSpeed]){
                (error) in
                if let e = error{
                    print("There was an issue saving data to firestore, \(e)")
                }else{
                    print("Successfully saved data.")
                    self.performSegue(withIdentifier: "params3ToParams4", sender: self)
                }
            }
        }
    }
}
