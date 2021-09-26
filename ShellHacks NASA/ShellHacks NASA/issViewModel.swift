//
//  issViewModel.swift
//  ShellHacks NASA
//
//  Created by Peter Khouly on 9/24/21.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import CoreLocation

class issViewModel: ObservableObject {
    
//    @Published var issCoordinates: CLLocationCoordinate2D? = nil
    init() {
        issLocation()
    }
    @Published var annotations: [Location] = [
    ]
    func issLocation() {
        annotations.removeAll()
        
        AF.request("http://api.open-notify.org/iss-now.json?", method: .get, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.annotations.append(Location(name: "International Space Station", coordinate: CLLocationCoordinate2D(latitude: json["iss_position"]["latitude"].doubleValue, longitude: json["iss_position"]["longitude"].doubleValue)))
//                self.issCoordinates = CLLocationCoordinate2D(latitude: json["iss_position"]["latitude"].doubleValue, longitude: json["iss_position"]["longitude"].doubleValue)
            case .failure(_):
                break
            }
        }
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
