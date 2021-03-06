//
//  StudentLocationViewController.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
    
    // MARK: @IBOutlet and constants
    
    @IBOutlet weak var onStudentsMap: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let limit: Int = FilterByStudent.MEDIUM
    let order: String = OrderByStudent.updatedAt
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onStudentsMap.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getStudentList()
    }
    
    // MARK: Actions on ViewController
    
    @IBAction func refreshStudents(_ sender: Any) {
        self.getStudentList()
    }
    
    // MARK: Add Mark annotations
    
    private func getStudentList() {
        setLoggingIn(true)
        UdacityClient.getStudentLocationList(limit: limit, order: order) { studentLocations, error in
            StudentLocationModel.shared.studentlist = studentLocations
            self.addMarkAnnotations()
            self.setLoggingIn(false)
        }
    }
    
    private func addMarkAnnotations() {
        let locations = StudentLocationModel.shared.studentlist
        var annotations = [MKPointAnnotation]()

        for dictionary in locations {
            let lat = CLLocationDegrees(dictionary.latitude )
            let long = CLLocationDegrees(dictionary.longitude )
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        self.removeAllAnnotationsToMAp()
        self.onStudentsMap.addAnnotations(annotations)
    }
    
    private func removeAllAnnotationsToMAp() {
        let allAnnotations = self.onStudentsMap.annotations
        self.onStudentsMap.removeAnnotations(allAnnotations)
    }

    // MARK: Loggin Animations
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

// MARK: MKMap delegte
extension MapViewController: MKMapViewDelegate {
    
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
        
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let urlExtern = view.annotation?.subtitle! {
                Utils.openURL(urlString: urlExtern, view: self)
            }
        }
    }
    
    
}
