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
    var totalKm = "totalKilometersAllTime"
    var totalTimeRunning = "totalMinutesRan"
    var totalRuns = "totalNumberOfRuns"
    var longestRun = "longestRun"
    var fastestRun = "fastestRun"
    var allTimeMaxT = "maxTempAllTime"
    var allTimeMinT = "minTempAllTime"
    var allTimeMaxW = "maxWindAllTime"
    var allTimeMaxH = "maxHumAllTime"
    var allTimeMinH = "minHumAllTime"
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        if let radius = searchRadiusTextField.text, let documentName = Auth.auth().currentUser?.email{
            db.collection("Users").document(documentName).updateData([searchRad:radius, totalKm: "0", totalTimeRunning: "0", totalRuns: "0", longestRun: "0", fastestRun: "0", allTimeMaxT: "0", allTimeMinT: "0", allTimeMaxW: "0", allTimeMaxH: "0", allTimeMinH: "0"]){
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
