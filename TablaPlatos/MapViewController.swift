//
//  MapViewController.swift
//  TablaPlatos
//
//  Created by Camilo Alfonso on 11/11/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

    
    @IBOutlet weak var MapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Todo bien, todo bonito")
        // Do any additional setup after loading the view.
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        MapView.camera = camera
        MapView.isMyLocationEnabled = true
        
        agregarMarcador(latitud: MapView.camera.target.latitude, longitud: MapView.camera.target.longitude)
    }

    func agregarMarcador(latitud:Double, longitud:Double){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = MapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
