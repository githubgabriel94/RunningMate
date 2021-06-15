//
//  ProfileMainViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 3/29/21.
//

import UIKit
import Firebase

class ProfileMainViewController: UIViewController {
    
    var db = Firestore.firestore()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalRuns: UILabel!
    @IBOutlet weak var totalRan: UILabel!
    @IBOutlet weak var avgDistancePerRun: UILabel!
    @IBOutlet weak var hoursRunning: UILabel!
    @IBOutlet weak var longestRun: UILabel!
    @IBOutlet weak var fastestRun: UILabel!
    @IBOutlet weak var maxTempAllTime: UILabel!
    @IBOutlet weak var minTempAllTime: UILabel!
    @IBOutlet weak var maxWindSpeedAllTime: UILabel!
    @IBOutlet weak var maxHumAllTime: UILabel!
    @IBOutlet weak var minHumAllTime: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        if let documentName = Auth.auth().currentUser?.email{
            let docRef = db.collection("Users").document(documentName)
            
            docRef.getDocument{ (document, error) in
                if let document = document, document.exists{
                    
                    let userName = document.get("Name")
                    let userLastName = document.get("LastName")
                    let totalRuns = document.get("totalNumberOfRuns")
                    let totalRan = document.get("totalKilometersAllTime")
                    let hoursRunning = document.get("totalMinutesRan")
                    let longestRun = document.get("longestRun")
                    let fastestRun = document.get("fastestRun")
                    let maxTempAllTime = document.get("maxTempAllTime")
                    let minTempAllTime = document.get("minTempAllTime")
                    let maxWindSpeedAllTime = document.get("maxWindAllTime")
                    let maxHumAllTime = document.get("maxHumAllTime")
                    let minHumAllTime = document.get("minHumAllTime")
                    
                    self.nameLabel.text = (userName as! String) + " " + (userLastName as! String)
                    self.totalRuns.text = (totalRuns as! String)
                    self.totalRan.text = (totalRan as! String) + " Km"
                    self.avgDistancePerRun.text = self.averageDistance(runs: totalRuns as! String, distance: totalRan as! String) + " Km"
                    self.hoursRunning.text = self.minutesToHours(mins: hoursRunning as! String) + " hs"
                    self.longestRun.text = (longestRun as! String) + " Km"
                    self.fastestRun.text = (fastestRun as! String) + " Km/h"
                    self.maxTempAllTime.text = (maxTempAllTime as! String) + " °C"
                    self.minTempAllTime.text = (minTempAllTime as! String) + " °C"
                    self.maxWindSpeedAllTime.text = (maxWindSpeedAllTime as! String) + " Km/h"
                    self.maxHumAllTime.text = (maxHumAllTime as! String) + " %"
                    self.minHumAllTime.text = (minHumAllTime as! String) + " %"
                }
            }
        }
    }
    
    func minutesToHours(mins: String)-> String{
        
        let minutesInt = Int(mins) ?? 0
        
        let hours = minutesInt / 60
        
        return String(hours)
    }
    
    func averageDistance(runs: String, distance: String) -> String {
        
        let runsInt = Int(runs) ?? 0
        let distanceInt = Int(distance) ?? 0
        var averageDist = 0
        
        if runsInt != 0{
            averageDist = distanceInt/runsInt
        }
        
        return String(averageDist)
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
