//
//  FindLocationViewController.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import UIKit
import CoreLocation

class FindLocationViewController: UIViewController {
    
    // MARK: @IBOutlets
    @IBOutlet weak var stringLocationText: UITextField!
    @IBOutlet weak var urlWebText: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var flagKeyBoard = false;
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D();
    lazy var geocoder = CLGeocoder()

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "completeLocation" {
            let detailLocation = segue.destination as! AddLocationViewController
            detailLocation.studentLocation = StudentLocation(
                                                uniqueKey: "",
                                                firstName: "",
                                                lastName: "",
                                                mapString: stringLocationText.text!,
                                                mediaURL: urlWebText.text!,
                                                latitude: coordinate.latitude,
                                                longitude: coordinate.longitude)
        }
    }
    
    // MARK: Actions on ViewController
    
    @IBAction func findLocationTapped(_ sender: Any) {
        if stringLocationText.text!.isEmpty {
            Utils.showLoginFailure(title: "Error Location", message: "The Address textfiel is empty.", view: self)
        } else if urlWebText.text!.isEmpty {
            Utils.showLoginFailure(title: "Error URL Web", message: "The url web textfiel is empty.", view: self)
        } else {
            setLoggingIn(true)
            geocode(address: stringLocationText.text!)
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Forward Geocode
    
    func geocode(address: String) {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {

        if error != nil {
            Utils.showLoginFailure(title: "Error Location", message: "Unable to Forward Geocode Address.", view: self)
        } else {
            var location: CLLocation?

            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }

            if let location = location {
                coordinate = location.coordinate
                performSegue(withIdentifier: "completeLocation", sender: nil)
            } else {
                Utils.showLoginFailure(title: "Error Location", message: "No Matching Location Found.", view: self)
            }
        }
        
        setLoggingIn(false)
    }
    
    // MARK: Loggin Animations
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        stringLocationText.isEnabled = !loggingIn
        urlWebText.isEnabled = !loggingIn
        findLocationButton.isEnabled = !loggingIn
    }
}


// MARK: KeyBoard controller

extension FindLocationViewController {
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if !flagKeyBoard {
            if stringLocationText.isFirstResponder || urlWebText.isFirstResponder {
                view.frame.origin.y -= getKeyboardHeight(notification) - 120 - urlWebText.frame.height - findLocationButton.frame.height
            }
            flagKeyBoard = true
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if !flagKeyBoard {
            if stringLocationText.isFirstResponder || urlWebText.isFirstResponder {
                view.frame.origin.y = 0
            }
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}
