//
//  LaunchView.swift
//  ShellHacks NASA
//
//  Created by Peter Khouly on 9/25/21.
//

import SwiftUI

struct LaunchView: View {
    @StateObject var vm = LaunchViewModel()
    
    let dateFormatter = DateFormatter()

    var body: some View {
        Form {
            if vm.failed {
                Text("Requests Limited.")
            } else {
                ForEach(vm.rockets) { i in
                    RocketCard(name: i.name, date: i.date, owner: i.owner, typeOfOwner: i.typeOfOwner, missionName: i.missionName, missionDesc: i.missionDesc, launchPad: i.launchPad, image: i.image, dateFormatter: dateFormatter)
                }
            }
        }.toolbar(content: {
            ToolbarItem {
                Button(action: {vm.load()}) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        })
        .onAppear {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
        }
    }
}

struct RocketCard: View {
    let name: String
    let date: Date?
    let owner: String
    let typeOfOwner: String
    let missionName: String
    let missionDesc: String
    let launchPad: String
    let image: String
    
    let dateFormatter: DateFormatter
    
    var body: some View {
        Section {
            Text(name).font(.title2).bold().foregroundColor(.primary)
            Label(
                title: {
                    if let date = date {
                        Text("Lift Off: ").bold() + Text("\(dateFormatter.string(from: date))")
                    } else {
                        Text("unknown date")
                    }
                },
                icon: { Image(systemName: "calendar") }
            )
            Label(
                title: { Text("Launch Pad: ").bold() + Text("\(launchPad)") },
                icon: { Image(systemName: "location").foregroundColor(.blue) }
            )
            Label(
                title: { Text("Owner: ").bold() + Text("\(owner)") },
                icon: { Image(systemName: "person.circle").foregroundColor(.green) }
            )
            Label(
                title: { Text(typeOfOwner).bold() },
                icon: { Image(systemName: "tag").foregroundColor(.green) }
            )
            Label(
                title: { Text("Mission: ").bold() + Text("\(missionName)") },
                icon: { Image(systemName: "shield").foregroundColor(.purple) }
            )
            Label(
                title: { Text("Description: ").bold() + Text("\(missionDesc)") },
                icon: { Image(systemName: "newspaper").foregroundColor(.purple) }
            )
        }
    }
}
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            RocketCard(name: "Rocket Ship", date: Date(), owner: "Chinese", typeOfOwner: "Governement", missionName: "mars expo", missionDesc: "going to mars to find life", launchPad: "american launch pad", image: "", dateFormatter: DateFormatter())
        }
    }
}
