//
//  GetStartedViewController.swift
//  cup_of_tea
//
//  Created by Liuqing Ma on 11/30/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import CoreLocation

class GetStartedViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    let locationManager = CLLocationManager()
//    var userInstance = UserProfile.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        let sv = UIViewController.displaySpinner(onView: self.view)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
//        let group = DispatchGroup()
//        group.enter()
        
        // avoid deadlocks by not using .main queue here
        DispatchQueue.main.async {
            self.locationManager.requestLocation()
            UIViewController.removeSpinner(spinner: sv)
        }
        
//        group.wait()
        
        
    }
    
    @IBAction func BtnPressed(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension GetStartedViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            UserProfile.sharedInstance.lat = lat
            UserProfile.sharedInstance.lng = long
            print("The location of user: \(lat),\(long)")
            lookUpCurrentLocation { geoLoc in
                print("loc in get started", geoLoc?.locality ?? "unknown Geo location")
            }
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
