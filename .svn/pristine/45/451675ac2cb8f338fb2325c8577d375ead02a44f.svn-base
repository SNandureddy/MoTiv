//
//  DirectionVC.swift
//  MoTiv
//
//  Created by IOS on 30/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import MapKit

class DirectionVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapButton: UIButton!
    
    //MARK: Variables
    
    var selectedIndex = Int()
    var type: PreviousScreen = .main
    var categoryEventDetailArray = [SearchEventDetail]()

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: kGetDirections)
        mapButton.setBackgroundImage(mapButton.graidentImage, for: .normal)
        mapButton.set(radius: 14.0)
    }
    
    @IBAction func mapButtonAction(_ sender: UIButton) {
        if type == .search {
            self.openMapForPlace(lat: categoryEventDetailArray[selectedIndex].eventLatitude ?? 0.0, long: categoryEventDetailArray[selectedIndex].eventLongitude ?? 0.0, name: categoryEventDetailArray[selectedIndex].eventLocation ?? "")
        } else {
            self.openMapForPlace(lat: EventVM.shared.eventDetailArray?[selectedIndex].eventLatitude ?? 0.0, long: EventVM.shared.eventDetailArray?[selectedIndex].eventLongitude ?? 0.0, name: EventVM.shared.eventDetailArray?[selectedIndex].eventLocation ?? "")
        }
    }
}
