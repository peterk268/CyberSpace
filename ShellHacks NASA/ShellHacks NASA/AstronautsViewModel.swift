//
//  AstronautsViewModel.swift
//  ShellHacks NASA
//
//  Created by Peter Khouly on 9/25/21.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

class AstronautsViewModel: ObservableObject {
    
    @Published var astronautsInSpace: [astronaut] = []
    
    @Published var count = 0
    init() {
        load()
    }
    func load() {
        astronautsInSpace.removeAll()
        
        AF.request("http://api.open-notify.org/astros.json?", method: .get, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let people = json["people"]
                self.count = json["number"].intValue
                for (_, subJson):(String, JSON) in people {
                    self.astronautsInSpace.append(astronaut(name: subJson["name"].stringValue, craft: subJson["craft"].stringValue))
                }
            case .failure(_):
                print("failed")
                break
            }
        }
    }
}

struct astronaut: Identifiable {
    let id = UUID()
    var name: String
    var craft: String
}
