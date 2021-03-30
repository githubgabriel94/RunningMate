//
//  SignUpViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/27/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                    self.errorLabel.text = e.localizedDescription
                }else{
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let e = error{
                            print(e)
                        }else{
                            self.performSegue(withIdentifier: "RegisterToUserInfo", sender: self)
                        }
                    }
                }
            }
        }
    }
    
}
