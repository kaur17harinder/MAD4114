//
//  ViewController.swift
//  MySecondMap
//
//  Created by MacStudent on 2018-07-19.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.mapView.delegate = self
        let coord = CLLocationCoordinate2DMake(-45.0312, 168.6626)
        let span = MKCoordinateSpanMake(5, 5)
        let region = MKCoordinateRegionMake(coord, span)
        mapView.setRegion(region, animated: true)
        
        //create polyline
        
        //1.CREATE AN ARRAY OF LOCATIONS
        let b = [
        CLLocationCoordinate2DMake(-45.0312, 168.6626), //queensland
        CLLocationCoordinate2DMake(-46.4132, 168.3538)] //invercargill
        
        //2.CREATE MK POLYLINE OBJECT AND TELL IT ABOUT LOCATION
        let polyline = MKPolyline(coordinates: b, count: b.count)
        //3.add it to map
        self.mapView.add(polyline)
       
    }

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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

