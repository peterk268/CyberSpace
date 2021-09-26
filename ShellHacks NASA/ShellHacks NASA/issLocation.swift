//
//  issLocation.swift
//  ShellHacks NASA
//
//  Created by Peter Khouly on 9/24/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct issLocation: View {
    @StateObject var vm = issViewModel()
    
    var manager = CLLocationManager()
    
    var body: some View {
        VStack {
            if let coordinates = vm.annotations {
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinates.first?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 70, longitudeDelta: 70))), interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: coordinates) { coordinate in
                    MapPin(coordinate: coordinate.coordinate)
                }
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            } else {
                ProgressView()
            }
            Text("Note: The International Space Station is moving at close to 28,000 km/h so it's location changes really fast!").font(.caption).padding(.vertical, 7)
        }
        .onAppear {
            manager.requestWhenInUseAuthorization()
        }
        .toolbar(content: {
            ToolbarItem {
                Button(action: {vm.issLocation()}) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        })
           
    }
}

struct issLocation_Previews: PreviewProvider {
    static var previews: some View {
        issLocation()
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
