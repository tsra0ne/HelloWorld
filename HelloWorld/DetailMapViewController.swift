//
//  DetailMapViewController.swift
//  HelloWorld
//
//  Created by Sravan on 04/04/26.
//

import UIKit
import SnapKit
import MapKit

class DetailMapViewController: UIViewController {
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    private let restaurant: Restaurant?
    
    init(restaurant: Restaurant?) {
        self.restaurant = restaurant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupMapView()
    }

    private func setupViews() {
        view.addSubview(mapView)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupMapView() {
        guard let query = restaurant?.location, !query.isEmpty else { return }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query

        // If you have a general region to bias results, you can set it here; otherwise, use the current map visible region
        request.region = mapView.region

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self = self else { return }
            // Clear existing annotations
            self.mapView.removeAnnotations(self.mapView.annotations)

            guard error == nil, let mapItem = response?.mapItems.first else { return }

            let coordinate = mapItem.location.coordinate
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = restaurant?.name
            annotation.subtitle = restaurant?.type

            self.mapView.addAnnotation(annotation)

            // Zoom to a reasonable region around the found coordinate
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion(center: coordinate, span: span)
//            self.mapView.setRegion(region, animated: true)
            
//            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
//            self.mapView.setRegion(region, animated: false)
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
}

