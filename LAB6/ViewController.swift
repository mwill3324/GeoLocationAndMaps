//
//  ViewController.swift
//  LAB6
//
//  Created by Marcus Williams on 10/30/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import UIKit
import MapKit



class ViewController: UIViewController, UISearchBarDelegate {
    var coords: CLLocationCoordinate2D?

    @IBAction func searchButton(_ sender: Any)
    {
        let searchController = UISearchController(searchResultsController:nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        
    }
    @IBOutlet var MyMap: MKMapView!
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle =  UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearchRequest()
        
        searchRequest.naturalLanguageQuery = searchBar.text
        searchRequest.region = MyMap.region
        
        let request = MKLocalSearch(request: searchRequest)
        
        let activeSearch = request
        
        activeSearch.start {(response,error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("error")
            }
            else{
                
                let annotations = self.MyMap.annotations
                self.MyMap.removeAnnotations(annotations)
                for result in (response?.mapItems)!
                {
                    let latitude = result.placemark.coordinate.latitude
                    let longitude = result.placemark.coordinate.longitude
                    let annotation = MKPointAnnotation()
                    annotation.title = result.name
                    annotation.subtitle = "1"
                    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                    self.MyMap.addAnnotation(annotation)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let geoCoder = CLGeocoder()
        let addressString = "\(city),\(state),\(country)"
        geoCoder.geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                if error != nil {
                    print("Geocode failed with error: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    self.coords = location!.coordinate
                    self.showMap()
                }
                
        })
    }
    
    
    @IBOutlet var SearchBar: UISearchBar!
    
    func showMap() {
        
        let center = CLLocationCoordinate2D(latitude: (coords?.latitude)!, longitude: (coords?.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        MyMap.setRegion(region, animated: true)
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake((coords?.latitude)!,(coords?.latitude)!);
        myAnnotation.title = city
        self.MyMap.addAnnotation(myAnnotation)
        
        //mapItem.openInMaps(launchOptions: options)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


