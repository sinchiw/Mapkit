//
//  GoogleMap.swift
//  SampleAppleMap
//
//  Created by Wilmer sinchi on 6/21/18.
//  Copyright © 2018 TurnToTech. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps


class GoogleMapViewController: UIViewController {
    
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let camera = GMSCameraPosition.camera(withLatitude: 40.7127753, longitude: -73.989308, zoom: 10.0)
        mapView.camera = camera
        showMarker(position: camera.target)
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "TurnToTech"
        marker.snippet = "New York"
        marker.map = mapView
    }
}
extension GoogleMapViewController: GMSMapViewDelegate{
    
}







