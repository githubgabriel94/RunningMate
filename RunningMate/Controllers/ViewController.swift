//
//  ViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/25/21.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet weak var MainAppTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainAppTitle.text = ""
        var charIndex = 0.0
        let titleText = "RunningMate"
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){ (timer) in
                self.MainAppTitle.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

