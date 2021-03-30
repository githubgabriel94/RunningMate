//
//  ViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainAppTitle: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainAppTitle.text? = ""
        var charIndex = 0.0
        let titleText = "RunningMate"
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){ (timer) in
                self.mainAppTitle.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
}

