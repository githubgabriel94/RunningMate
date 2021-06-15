//
//  WeatherViewController.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 6/13/21.
//

import CoreLocation
import UIKit
import Firebase

class WeatherViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    let db = Firestore.firestore()
    
    var run = true
    var maxTemp:Double = 0
    var minTemp:Double = 0
    var maxChance:Int = 0
    var maxWind:Double = 0
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var currentDescLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherMessageLabel: UILabel!
    @IBOutlet weak var weatherCardView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
        if let documentName = Auth.auth().currentUser?.email{
            let docRef = db.collection("Users").document(documentName)
            
            docRef.getDocument{ (document, error) in
                if let document = document, document.exists{
                
                    let maxTempS = document.get("MaximunTemp")
                    self.maxTemp = Double(maxTempS as! String) ?? 0
                    
                    let minTempS = document.get("MinimunTemp")
                    self.minTemp = Double(minTempS as! String) ?? 0
                    
                    let maxWindS = document.get("MaxWind")
                    self.maxWind = Double(maxWindS as! String) ?? 0
                    
                    let maxChanceS = document.get("MaxChanceOfPreci")
                    self.maxChance = Int(maxChanceS as! String) ?? 0
                }
            }
        }
        
        self.titleLabel.isHidden = true
        self.weatherCardView.isHidden = true
        self.continueButton.isHidden = true
        self.weatherMessageLabel.text = "LOADING..."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
    }
    
    func chooseMessage(w: WeatherModel) -> Bool{

        if (w.temperature > minTemp && w.temperature < maxTemp && w.windSpeed < maxWind && (Int(w.chancePrec) * 100) < maxChance){
            return true
        }
        return false
    }
    
    func loaded(){
        
        self.titleLabel.isHidden = false
        self.weatherCardView.isHidden = false
        self.continueButton.isHidden = false
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            if #available(iOS 13.0, *) {
                self.weatherImage.image = UIImage(systemName: weather.conditionName)
            } else {
                // Fallback on earlier versions
            }
            self.tempLabel.text = weather.temperatureString + " °C"
            self.currentDescLabel.text = weather.currentDesc
            self.windSpeedLabel.text = "Wind Speed: " + weather.windSpeedString + " Km/h"
            self.popLabel.text = "Chance of Rain: " + weather.popString + "%"
            self.visibilityLabel.text = "Visibility: " + weather.visibilityString + " m"
            self.humidityLabel.text = "Humidity: " + weather.humidityString + "%"
            if self.run == false{
                self.weatherMessageLabel.text = "Not the weather you like but...GO GET OUT YOUR CONFORT ZONE!"
                self.continueButton.setTitle("Continue Anyway", for: .normal)
                self.loaded()
            }else{
                self.weatherMessageLabel.text = "Now this weather your do like! GO GO GO!"
                self.loaded()
            }
        }
        run = self.chooseMessage(w: weather)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
