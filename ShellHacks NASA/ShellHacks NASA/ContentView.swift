//
//  ContentView.swift
//  ShellHacks NASA
//
//  Created by Peter Khouly on 9/24/21.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                AstranuatsView()
                    .navigationTitle("Astronauts")
            }
            .tabItem {
                Label("Astronauts", systemImage: "person.3")
            }
            .tag(0)
            
            NavigationView {
                issLocation()
                    .navigationBarTitle("ISS Locator", displayMode: .inline)
            }
            .tabItem {
                Label("ISS Locator", systemImage: "globe")
            }
            .tag(1)
            
            NavigationView {
                LaunchView()
                    .navigationBarTitle("Launch Times")
            }
            .tabItem {
                Label("Launch Times", systemImage: "deskclock")
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
