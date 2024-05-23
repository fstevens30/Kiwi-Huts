//
//  AboutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI
import AVKit

struct AboutView: View {
    func getAppVersion() -> String {
            if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                return appVersion
            }
            return "Unknown"
        }
    
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "video",
                                                      withExtension: "mp4")!)
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(20)
                    .shadow(radius: 20)
            }
            .padding()
            
            Spacer()
            
            VStack {
                Text("Kiwi Huts")
                    .font(.headline)
                Text("Version \(getAppVersion())")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            VStack {
                Text("This app was made by Flynn Stevens as a side project to understand more about SwiftUI and API usage. All data on this app is pulled from the Department of Conservation API.")
                    .padding()
                
                Text("Remember, please refer to the DOC website and local weather before heading out on adventures. For more information on this app please see below.")
                    .padding()
            }
            .padding()
            
            Spacer()
            
            VStack {
                Text ("Tutorial")
                    .font(.headline)
                
                VideoPlayer(player: player)
                                .frame(width: 320, height: 180, alignment: .center)
                
            }
            
            HStack {
                Link("GitHub Link", destination: URL(string:"https://github.com/fstevens30")!)
                    .buttonStyle(.bordered)
                Link("DOC API", destination: URL(string: "https://api.doc.govt.nz/")!)
                    .buttonStyle(.bordered)
            }
            
            Spacer()
        }
    }
}

#Preview {
    AboutView()
}
