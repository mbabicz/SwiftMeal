//
//  MapView.swift
//  SwiftMeal
//
//  Created by mbabicz on 10/09/2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var currentLongitude: Double
    var currentLatitude: Double

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let location = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location

        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotation(annotation)

        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        uiView.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(currentLongitude: 45.213132, currentLatitude: 27.23123)
    }
}
