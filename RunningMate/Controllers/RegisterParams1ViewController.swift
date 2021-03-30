//
//  RegisterParams1ViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/29/21.
//

import UIKit
import Firebase

class RegisterParams1ViewController: UIViewController{
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var maxTempTextField: UITextField!
    @IBOutlet weak var tempsPBar: UIProgressView!
    
    var minTemp = "MinimunTemp"
    var maxTemp = "MaximunTemp"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        if let min = minTempTextField.text, let max = maxTempTextField.text, let documentName = Auth.auth().currentUser?.email{
            db.collection("Users").document(documentName).setData([minTemp: min, maxTemp:max]){
                (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                }else{
                    print("Successfully saved data.")
                    self.performSegue(withIdentifier: "params1ToParams2", sender: self)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
}
