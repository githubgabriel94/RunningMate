//
//  RegisterParams4ViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/30/21.
//

import UIKit
import Firebase

class RegisterParams4ViewController: UIViewController{
    
    var db = Firestore.firestore()
    
    @IBOutlet weak var pBarSearchRad: UIProgressView!
    @IBOutlet weak var searchRadiusTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var searchRad = "searchRadius"
    var totalKm = "totalKmRan"
    var totalTimeRunning = "totalMinutesRan"
    var totalCalories = "totalCaloriesBurnt"
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        if let radius = searchRadiusTextField.text, let documentName = Auth.auth().currentUser?.email{
            db.collection("Users").document(documentName).updateData([searchRad:radius, totalKm: "0", totalTimeRunning: "0", totalCalories: "0"]){
                (error) in
                if let e = error{
                    print("There was an issue saving data to firestore, \(e)")
                }else{
                    print("Successfully saved data.")
                    self.performSegue(withIdentifier: "params4ToCongrats", sender: self)
                }
            }
        }
    }
    
}
