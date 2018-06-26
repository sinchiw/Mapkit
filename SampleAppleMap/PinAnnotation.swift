
import MapKit

class PinAnnotation : NSObject, MKAnnotation{
    
    var title : String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var url : String?
//    var costumeID: String?
    
    init(title : String ,subtitle : String ,coordinate : CLLocationCoordinate2D, url: String)
    {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.url = url
//        self.costumeID = costumeID
    }
}
    
    
    
    

