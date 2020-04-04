//
//  MapView.swift
//  Covid-19 Tracker
//
//  Created by Eric Bates on 4/2/20.
//  Copyright © 2020 Eric Bates. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MKMapView {
           MKMapView(frame: .zero)
       }
    
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 0.0, longitude: 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(.world)
        uiView.setRegion(region, animated: true)
    }
    
    func changeMapLocation(latitude: Double,longitude: Double,_ uiView: MKMapView ){
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
