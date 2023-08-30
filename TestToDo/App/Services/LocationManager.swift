import UIKit
import MapKit
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationUpdatedSubject = PassthroughSubject<(String?, String?), Never>()
    
    let locationManager = CLLocationManager()
    private var city: String?
    private var country: String?
    private var newLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopUpdatingLocation()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailError")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        newLocation = locations.first
        if let newLocation = newLocation {
            getPlacemarkFromLocation(newLocation)
        }
    }
    
    func getPlacemarkFromLocation(_ location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print("Empty != nil")
            }
            if placemarks!.count > 0 {
                let placemark = placemarks?.first
                self.city = placemark?.locality
                self.country = placemark?.country
                self.locationUpdatedSubject.send((self.city, self.country))
            } else {
                print("No placemarks found")
            }
        }
    }
    
    public func getCity() -> String? {
        return city
    }
    
    public func getCountry() -> String? {
        return country
    }
}


