//
//  AboutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var viewModel: HutsViewModel
    
    func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "Unknown"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var body: some View {
        ScrollView {
            Spacer()
            VStack {
                AppVersionInformationView(
                    versionString: AppVersionProvider.appVersion(),
                    appIcon: AppIconProvider.appIcon()
                )
            }
            .padding()
            
            Spacer()
            
            VStack {
                Text("Kiwi Huts")
                    .font(.headline)
                if let lastUpdated = viewModel.lastUpdated {
                    Text("Last updated: \(formatDate(lastUpdated))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("No updates yet")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            VStack {
                Text("This app was made by Flynn Stevens as a side project to understand more about SwiftUI and API usage. All data on this app is pulled from the Department of Conservation API.")
                    .padding(.bottom)
                
                Text("Remember, please refer to the DOC website and local weather before heading out on adventures. Data is updated once daily. For more information on this app please see below.")
                    .padding(.bottom)
            }
            .padding()
            
            Spacer()
            
            HStack {
                Link("GitHub Link", destination: URL(string:"https://github.com/fstevens30/Kiwi-Huts")!)
                    .buttonStyle(.bordered)
                Link("DOC API", destination: URL(string: "https://api.doc.govt.nz/")!)
                    .buttonStyle(.bordered)
            }
            .padding()
            
            Spacer()
        }
        .statusBarHidden(false)
    }
}

#Preview {
    AboutView()
        .environmentObject(HutsViewModel())
}
