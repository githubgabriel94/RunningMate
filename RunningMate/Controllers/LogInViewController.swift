//
//  LogInViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/27/21.
//

import UIKit
import Firebase

class LogInViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func logInPressed(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.errorLabel.text = e.localizedDescription
                }else{
                    self.performSegue(withIdentifier: "logInToHome", sender: self)
                }
              
            }
        }
    }
}
