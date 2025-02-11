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
        NavigationStack {
            ScrollView {
                VStack {
                    AppVersionInformationView(
                        versionString: AppVersionProvider.appVersion(),
                        appIcon: AppIconProvider.appIcon()
                    )
                }
                
                VStack {
                    Text("Kiwi Huts")
                        .font(.headline)
                }
                Divider()
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Text("Remember, please refer to the DOC website and local weather before heading out on adventures. Data is updated twice a day. For more information on this app please see below.")
                    
                    Text("All data on this app is pulled from the Department of Conservation API. Please refer to the timestamp below to see when the data was last updated.")
                }
                .padding()
                
                HStack {
                    Link("GitHub Link", destination: URL(string:"https://github.com/fstevens30/Kiwi-Huts")!)
                        .buttonStyle(.bordered)
                    Link("DOC API", destination: URL(string: "https://api.doc.govt.nz/")!)
                        .buttonStyle(.bordered)
                }
                .padding()
                
                if let lastUpdated = viewModel.lastUpdated {
                    Text("Data last updated: \(formatDate(lastUpdated))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    Text("No data yet")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .statusBarHidden(false)
            .navigationTitle("About")
        }
    }
}

#Preview {
    AboutView()
        .environmentObject(HutsViewModel())
}
