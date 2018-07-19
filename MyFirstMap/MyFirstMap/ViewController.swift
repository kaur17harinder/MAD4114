//
//  ViewController.swift
//  MyFirstMap
//
//  Created by MacStudent on 2018-07-19.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    //MARK - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var label: UILabel!
    //empty array of locations
    var mylocations : [CLLocationCoordinate2D] = []
    
    //make a core location variable
    var manager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        //1.COORDINATE: set the position of the  center of the map
           let coord = CLLocationCoordinate2DMake(43.6426, -79.3871)
        //2.SPAN; set the zoom level of the map
        //small numbers -- GO IN(CLOSER)
        //BIG NUMBERS -- GO OUT(FAR AWAY)
           let span = MKCoordinateSpanMake(0.0015, 0.0015)
        //3.REGION:create a region object for the map
        let region = MKCoordinateRegionMake(coord, span)
        //4.do some nonsense to show the map on the screen
        mapView.setRegion(region, animated: true)
 */
        //1.set up your core location variable
         self.manager = CLLocationManager()
        self.manager.delegate = self
        
        //2.tell ios how accurate you want the location to be
         self.manager.desiredAccuracy = kCLLocationAccuracyBest
        //3.ask the user for permission to get their location
         self.manager.requestAlwaysAuthorization()
        //4.get the user locatin
        self.manager.startUpdatingLocation()
        //UINONSENSE - set up the map to show thier location
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true //blinking blue dot
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     //MARK - corelocation related function
    //this function runs every time the person moves
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //1.logic: get the person moist recent position
    let i = locations.count - 1
label.text! = ("\(locations[i])")
        
        self.mylocations.append(mapView.userLocation.coordinate)
        if(self.mylocations.count > 2)
        {
            print("Drawing polyline")
             let polyline = MKPolyline(coordinates: self.mylocations, count: self.mylocations.count)
             self.mapView.add(polyline)
        }
        else
        {
            print("not drwaing polyline")
        }
       /*
        let b = [
            CLLocationCoordinate2DMake(-45.0312, 168.6626), //queensland
            CLLocationCoordinate2DMake(-46.4132, 168.3538)] //invercargill
        
        //2.CREATE MK POLYLINE OBJECT AND TELL IT ABOUT LOCATION
        let polyline = MKPolyline(coordinates: b, count: b.count)
        //3.add it to map
        self.mapView.add(polyline)
        */
        
        
        //2.uinonsense ; update the map to m,atch person location
        let coord = mapView.userLocation.coordinate
        let span = MKCoordinateSpanMake(0.0015, 0.0015)
        let region = MKCoordinateRegionMake(coord, span)
        mapView.setRegion(region, animated: true)
    }
    
    
    //MARK - polyline function
    //to show on map
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if(overlay is MKPolyline)
        {
            //4.show it on the map
            let a = MKPolylineRenderer(overlay: overlay)
            //configure the line
            //how ur line look
            a.strokeColor = UIColor.blue
            a.lineWidth = 1
            
            return a
        }
        return MKOverlayRenderer()
    }

}

