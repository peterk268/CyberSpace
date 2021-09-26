//
//  LaunchViewModel.swift
//  ShellHacks NASA
//
//  Created by Peter Khouly on 9/25/21.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

class LaunchViewModel: ObservableObject {
    
    @Published var rockets: [Rocket] = []
    
    let dateFormatter = DateFormatter()

    @Published var failed = false
    init() {
        load()
    }
    func load() {
        self.failed = false
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        rockets.removeAll()
        
        AF.request("http://ll.thespacedevs.com/2.2.0/launch/upcoming/?format=json", method: .get, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let ships = json["results"]
//                print(ships)
                for (_, subJson):(String, JSON) in ships {
                    let shipName = subJson["name"].stringValue
                    let date = subJson["net"].stringValue //2021-09-27T06:20:00Z format date
                    let owner = subJson["launch_service_provider"]["name"].stringValue
                    let typeOfOwner = subJson["launch_service_provider"]["type"].stringValue
                    let missionName = subJson["mission"]["name"].stringValue
                    let missionDesc = subJson["mission"]["description"].stringValue
                    let launchPad = subJson["pad"]["name"].stringValue
                    let image = subJson["image"].stringValue

                    self.rockets.append(Rocket(name: shipName, date: self.dateFormatter.date(from: date), owner: owner, typeOfOwner: typeOfOwner, missionName: missionName, missionDesc: missionDesc, launchPad: launchPad, image: image))

                }
            case .failure(_):
                self.failed = true
                print("failed")
                break
            }
        }
    }
}

struct Rocket: Identifiable {
    let id = UUID()
    var name: String
    var date: Date?
    var owner: String
    var typeOfOwner: String
    var missionName: String
    var missionDesc: String
    var launchPad: String
    var image: String
}
