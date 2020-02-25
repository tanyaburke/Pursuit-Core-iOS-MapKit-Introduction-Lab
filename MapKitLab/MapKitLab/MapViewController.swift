//
//  ViewController.swift
//  MapKitLab
//
//  Created by Tanya Burke on 2/24/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    private var schools = [School]()
    
    private let locationSession = CoreLocationSession()
    private var userTrackingButton: MKUserTrackingButton!
    
    private var  isShowingNewANNOtations = false
    
    private var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromBundle()
        mapView.showsUserLocation = true
        
        //configure traking button
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 40, width: 40, height: 40))
        //frame based layout
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView
        loadMap()
        
        //set map view delegate
        mapView.delegate = self
    }
    
    private func getDataFromBundle(){
        do{
            let jsonData = try SchoolSupplyService.fetchLocation()
            self.schools = jsonData
            dump(jsonData)
        }catch{
            print("\(error)")
        }
        
    }
    
    
    
    private func loadMap(){
        let annotations = makeAnnotations()
        mapView.addAnnotations(annotations)
        
    }
    
    private func makeAnnotations() -> [MKPointAnnotation]{
        var annotations = [MKPointAnnotation]()
        for school in schools{
            let annotation = MKPointAnnotation()
            annotation.title = school.schoolName
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(school.latitude)!, longitude: Double(school.longitude)!)
            annotations.append(annotation)
        }
        isShowingNewANNOtations = true
        self.annotations = annotations
        return annotations
    }
    
   
    
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation else{return}
        
        guard let location = (Location.getLocations().filter{$0.title == annotation.title}).first else {return}
//        guard let detailVC = storyboard?.instantiateViewController(identifier: "LocationDetailController", creator: { (coder)  in
//            return LocationDetailController(coder: coder, location: location)
//        }) else{
//            fatalError("")
//        }
//        detailVC.modalPresentationStyle = .overCurrentContext
//        detailVC.modalTransitionStyle = .flipHorizontal
//        //detailVC.modalTransitionStyle = .crossDissolve
//        present(detailVC, animated: true)
//        print("\(location) was selected")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else{ return nil}
        
        let identifier = "annotaton view"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.glyphImage = UIImage(named: "duck")
            
        } else {
            annotationView?.annotation = annotation
            
        }
        return annotationView
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if isShowingNewANNOtations{
            mapView.showAnnotations(annotations, animated: false)
            //set to false to avoid glitches
            
        }
        
        isShowingNewANNOtations = false
    }
}

