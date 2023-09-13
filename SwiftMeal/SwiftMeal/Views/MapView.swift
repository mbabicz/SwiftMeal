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
        mapView.mapType = .standard
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let location = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        uiView.removeOverlays(uiView.overlays)
        uiView.removeAnnotations(uiView.annotations)

        let deliveryAnnotation = MKPointAnnotation()
        deliveryAnnotation.coordinate = location
        uiView.addAnnotation(deliveryAnnotation)

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
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKPointAnnotation {
                let identifier = "annotation"
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                
                if annotationView == nil {
                    annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView?.image = createCircleImage(with: UIColor(named: "ThemeColor"), backgroundColor: .white)
                    annotationView?.centerOffset = CGPoint(x: 0, y: 0)
                } else {
                    annotationView?.annotation = annotation
                }
                
                return annotationView
            }
            
            return nil
        }
        
        func createCircleImage(with fillColor: UIColor?, backgroundColor: UIColor) -> UIImage {
            let size = CGSize(width: 22, height: 22)
            let circleRect = CGRect(x: 5, y: 5, width: 12, height: 12)
            let strokeWidth: CGFloat = 3
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context = UIGraphicsGetCurrentContext()!
            
            if let fillColor = fillColor {
                context.setFillColor(fillColor.cgColor)
            }
            context.setStrokeColor(backgroundColor.cgColor)
            context.setLineWidth(strokeWidth)
            
            context.fillEllipse(in: circleRect)
            context.strokeEllipse(in: circleRect)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image!
        }

    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(currentLongitude: 45.213132, currentLatitude: 27.23123)
    }
}
