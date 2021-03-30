//
//  ProfileMainViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/29/21.
//

import UIKit
import Firebase

class ProfileMainViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
    
    do {
      try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
        
    }
}
