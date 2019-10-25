//
//  AddLocationVC.swift
//  MoTiv
//
//  Created by IOS on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces


class AddLocationVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var locationTextField: TextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var isUpdate = false
    var selectedIndex = Int()
    
    //MARK: Variables
    var delegate: TabViewDelegate!
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        locationTextField.set(radius: 14.0)
        nextButton.set(radius: 14.0)
        mapView.set(radius: 14.0)
        nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
        setupTextField()
        setupMap()
        handleLocation()
    }
    
    private func setupTextField() {
        locationTextField.text!.count > 0 ? locationTextField.setShadow(): locationTextField.removeShadow()
        locationTextField.text!.count > 0 ? locationTextField.removeBackground(): locationTextField.addBackground()
    }
    
    //MARK: IBActions
    @IBAction func nextButtonAction(_ sender: UIButton) {
        delegate.didClickTab(tag: 4)
    }
    
    @IBAction func textFieldDidChange(_ sender: TextField) {
        setupTextField()
    }
}

//Setup Map
extension AddLocationVC {
    
    private func handleLocation() {
        let noLocation = isUpdate == true ? CLLocationCoordinate2D(latitude: EventVM.shared.eventDetailArray?[selectedIndex].eventLatitude ?? 0.0, longitude: EventVM.shared.eventDetailArray?[selectedIndex].eventLongitude ?? 0.0) : CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 150, 150)
        mapView.setRegion(viewRegion, animated: false)
        if isUpdate == true {
            self.handleAddress(coordinate: noLocation)
        } else {
            LocationManager.shared.askPermissionsAndFetchLocationWithCompletion { (location, placemark, error) in
                if error ==  nil {
                    let viewRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate, 200, 200)
                    self.mapView.setRegion(viewRegion, animated: false)
                    self.handleAddress(coordinate: location!.coordinate)
                }
            }
        }
    }
    
    private func setupMap() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        mapView.delegate = self
        
    }
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer) {
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        self.handleAddress(coordinate: coordinate)
    }
    
    private func handleAddress(coordinate: CLLocationCoordinate2D) {
        
        LocationManager.shared.getAddress(location: coordinate) { (address) in
            self.locationTextField.text = address
            self.setupTextField()
            O_CreateMainVC.createDict[APIKeys.kLatitude] = coordinate.latitude
            O_CreateMainVC.createDict[APIKeys.kLongitude] = coordinate.longitude
            O_CreateMainVC.createDict[APIKeys.kLocation] = address
        }
        
        // Add annotation
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
    }
}

extension AddLocationVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
}


// MARK: Google Places delegate
extension AddLocationVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        debugPrint(place.coordinate.latitude)
        debugPrint(place.coordinate.longitude)
        debugPrint("Place address: \(String(describing: place.formattedAddress))")
        dismiss(animated: true, completion: nil)
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = place.coordinate
        self.mapView.addAnnotation(annotation)

        O_CreateMainVC.createDict[APIKeys.kLatitude] = place.coordinate.latitude
        O_CreateMainVC.createDict[APIKeys.kLongitude] = place.coordinate.longitude
        O_CreateMainVC.createDict[APIKeys.kLocation] = place.formattedAddress
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        self.showErrorMessage(error: error)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}


extension AddLocationVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.image = #imageLiteral(resourceName: "mapMarker")   // go ahead and use forced unwrapping and you'll be notified if it can't be found; alternatively, use `guard` statement to accomplish the same thing and show a custom error message
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}