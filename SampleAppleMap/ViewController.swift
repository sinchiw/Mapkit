//
//  ViewController.swift
//  SampleAppleMap
//
//  Created by Aditya Narayan on 3/6/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit



//this is wher you put the class protocols

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}
//you delectef cllocationmanagerdelgate because you have the classs extesnion already which is in the botttom of the code
class ViewController: UIViewController, UISearchBarDelegate{
    var selectedPin:MKPlacemark? = nil
    var resultSearchController : UISearchController? = nil
    //this variable has controller-level scope to keep the uiseachcontroller in memory after it's created
    var locationManager:CLLocationManager = CLLocationManager()
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        //nill unless you want to use another viewcontroller as a searchcontroller for the completion ^^^^
        
     
    }
    
//    var locationManager:CLLocationManager = CLLocationManager()
    //this code below is aalread y adcoopied
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var turntotechLOGO: UIImageView!
    var customeID : String?
    var pin : PinAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        
        let location = CLLocationCoordinate2DMake(40.7098092, -74.0147341)
        //this code below zoom in on the pin when the map loads
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 2000, 2000), animated: true)
        pin = PinAnnotation(title: "TurnToTech", subtitle: "IOS Rocks!", coordinate: location, url: "https://www.apple.com/" )

//        customeID = "burger"
        
        let location2 =  CLLocationCoordinate2DMake(40.7088376, -74.0145647)
        let pin2 = PinAnnotation(title: "IHOB", subtitle: "House of Burger", coordinate: location2, url: "https://www.ihop.com/en?utm_source=google&utm_medium=cpc&gclid=CjwKCAjwpIjZBRBsEiwA0TN1r8kcwCDPu3-Y12519nSfdElhYUb0PC44HgnHOpUDbDarC2tV_f2JUxoCYpkQAvD_BwE&gclsrc=aw.ds")
       
        let location3 = CLLocationCoordinate2DMake(40.7065894, -74.01300479999998)
        let pin3 = PinAnnotation(title: "Burger King", subtitle: "Yolo", coordinate: location3, url: "https://www.bk.com/")
//

        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable 
        
        locationSearchTable.mapView = mapView
        
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        mapView.addAnnotation(pin3)
        mapView.addAnnotation(pin2)
        mapView.addAnnotation(pin)
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
//        locationManager.requestLocation()
        
        mapView.showsUserLocation = true
        mapView.bringSubview(toFront: turntotechLOGO)
        
        locationSearchTable.handleMapSearchDelegate = self

        
        
    }
    
    @objc func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    
    
    @IBAction func selectMapType(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = MKMapType.standard
            break;
        case 1:
            mapView.mapType = MKMapType.hybrid
            break;
        case 2:
            mapView.mapType = MKMapType.satellite
            break;
        default:
            break;
            
        }
    }
    
    
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        print(userLocation.coordinate)
//        let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 250, 250)
//        self.mapView.setRegion(region, animated: true)
//
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    ///this code belowe is already copied
    //dont forget tghe space
    func mapView(_ mapview: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let reuseIdentifier = "burgers"
        if annotation is MKUserLocation{
            return nil
        }
        
    //    if annotation.title == "TurnToTech" || annotation.title == "IHOB" || annotation.title == "Burger King"{
            
        
        //if you want to change the image make sure its on MKAnnotta{tionview
        let annotationView = MKPinAnnotationView(annotation: annotation , reuseIdentifier : "mylocation")
        
//        annotationView.isEnabled = true
        let heightForImageView = annotationView.frame.height - 10
        let imageview =  UIImageView(frame: CGRect(x: 0, y: 0, width: heightForImageView, height: heightForImageView))

     
        switch annotation.title {
        case "TurnToTech" :
            imageview.image = UIImage(named:"hamburger")
            annotationView.leftCalloutAccessoryView = imageview
            break
        case "IHOB" :
            imageview.image = UIImage(named:"corn")
            annotationView.leftCalloutAccessoryView = imageview
            break
        case "Burger King" :
            imageview.image = UIImage(named:"sandwich")
            annotationView.leftCalloutAccessoryView = imageview
            break
        default:
            
            
            break
        }
            
                    annotationView.isEnabled = true
                    annotationView.canShowCallout = true
            
        
        let btn = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = btn
        
       
        //
//        imageview.image = UIImage(named:"hamburger.png")
//        annotationView.leftCalloutAccessoryView = imageview
        
//        annotationView.image = imageview
//        annotationView.leftCalloutAccessoryView = imageview
//        annotationView.canShowCallout = true
//        annotationView.image = UIImage(named: "customPin")

//         annotationView.leftCalloutAccessoryView = imageview
//        annotationView.addSubview(mapview)
     //   let transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
      //  annotationView.transform = transform
        return annotationView
        


    }
    //this code below is copied alread hy
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
//        let annView = view.annotation
        let storyboard  = UIStoryboard(name: "Main", bundle:nil)
        let webpage = storyboard.instantiateViewController(withIdentifier: "detail") as! WebViewController
        if let pinFromMap = view.annotation as? PinAnnotation {
//        webpage.urlString = pinFromMap.url!
        self.navigationController?.pushViewController(webpage, animated: true)
        
        }
    }
    //this whole code is written below alreadt
    
//this function is part of the uisearchbardelegate and this funcation run when the user press the search bar button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //blocking any interaction event, or ignnoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        //activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        //hide the search bar once its searched
        // this contracts the keyboard
        searchBar.resignFirstResponder()
        //completion is nill since we dont have piece of code to run when its done.
        dismiss(animated: true, completion: nil)
        
        //create the search request
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery  = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        //get variable in return
        activeSearch.start{ (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil
            {
                print ("ERROR")
            }
            else
            {
                // Remove annoatation
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                
                //Getting the data\
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //create annotation
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                //zooming in on annotation
                
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                //how much you want to zoom in on the map
                
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
                
            }
            
        }
        
        
    }
}
//coede below here is copied
extension ViewController : CLLocationManagerDelegate {
    @nonobjc func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                locationManager.requestLocation()
            }
        }
        //locationManager(_:didChangeAuthorizationStatus:): This method gets called when the user responds to the permission dialog. If the user chose Allow, the status becomes CLAuthorizationStatus.AuthorizedWhenInUse.
    @nonobjc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            
                print("location:: (location)")
            }
        }
        //locationManager(_:didUpdateLocations:): This gets called when location information comes back. You get an array of locations, but you’re only interested in the first item. You don’t do anything with it yet, but eventually you will zoom to this location.
    @nonobjc func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
            print("error:: (error)")
        }
}


    
extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}
    
extension ViewController : MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), for: .normal)
        button.addTarget(self, action: #selector(ViewController.getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}

