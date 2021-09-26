//
//  AstranuatsView.swift
//  ShellHacks NASA
//
//  Created by Peter Khouly on 9/25/21.
//

import SwiftUI
import SafariServices

struct AstranuatsView: View {
    @StateObject var vm = AstronautsViewModel()
    var body: some View {
        Form {
            Section(header: Text("Astronauts in Space: \(vm.count)")) {
                ForEach(vm.astronautsInSpace) { i in
                    NavigationLink(
                        destination: SafariView(url: (URL(string: "https://en.wikipedia.org/wiki/\(i.name.replacingOccurrences(of: " ", with: "_"))") ?? URL(string: "apple.com"))!)
                            .navigationBarTitle(i.name, displayMode: .inline)
                        ,
                        label: {
                            HStack {
                                Label(i.name, systemImage: "person.crop.square").font(.headline)
                                Spacer()
                                Text(i.craft)
                            }
                        })
                }
                
            }
        }.toolbar(content: {
            ToolbarItem {
                Button(action: {vm.load()}) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        })
    }
}

struct AstranuatsView_Previews: PreviewProvider {
    static var previews: some View {
        AstranuatsView()
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
