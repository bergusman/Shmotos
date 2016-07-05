//
//  MapViewController.swift
//  Shmotos
//
//  Created by Vitaly Berg on 05/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - MKMapViewDelegate
    
    /*
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
    }
 */
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let result = PHAsset.fetchAssetsWithOptions(nil)
        for i in 0..<result.count {
            let asset = result[i] as! PHAsset
            
            if let location = asset.location {
                let p = MKPointAnnotation()
                p.coordinate = location.coordinate
                mapView.addAnnotation(p)
            }
        }
    }

}
