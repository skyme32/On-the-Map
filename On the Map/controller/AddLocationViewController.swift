//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import UIKit
import MapKit


class AddLocationViewController: UIViewController {
    
    // MARK: @IBOutlet
    
    @IBOutlet weak var onMapView: MKMapView!
    @IBOutlet weak var addLocationButton: UIButton!
    
    var studentLocation: StudentLocation!
    
    // MARK: Lifecicle

    override func viewDidLoad() {
        super.viewDidLoad()
        onMapView.delegate = self
        
        addLocationButton.isEnabled = false
        
        // Search own user
        handleSessionUser()
        
        // Map settings
        settingMap()
    }
    
    // MARK: Action button
    
    @IBAction func addLocationTapped(_ sender: Any) {
        UdacityClient.postStudentLocation(student: self.studentLocation, completion: handlePostStudentLocation(success:error:))
    }
    
    // MARK: Methods GET and POST
    
    func handleSessionUser() {
        UdacityClient.getUserSession() { user, error in
            if error == nil {
                self.studentLocation.firstName = user!.firstName
                self.studentLocation.lastName = user!.lastName
                self.studentLocation.uniqueKey = user!.key
                self.addLocationButton.isEnabled = true
            } else {
                Utils.showLoginFailure(title: "Session Failed", message: error?.localizedDescription ?? "", view: self)
            }
        }
    }
    
    func handlePostStudentLocation(success: Bool, error: Error?) {
        if success {
            self.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            Utils.showLoginFailure(title: "Add Location Failed", message: error?.localizedDescription ?? "", view: self)
        }
    }
    
    // MARK: Map settings
    
    func settingMap() {
        // Move the camera on Map
        let center = CLLocationCoordinate2D(latitude: studentLocation.latitude, longitude: studentLocation.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.30, longitudeDelta: 0.30))
        self.onMapView.setRegion(region, animated: true)
        
        // Add annotation
        let coordinate = CLLocationCoordinate2D(latitude: studentLocation.latitude, longitude: studentLocation.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(studentLocation.mapString)"
        annotation.subtitle = studentLocation.mediaURL
        self.onMapView.addAnnotation(annotation)
    }
}

// MARK: MKMap delegte
extension AddLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.orange
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

}
