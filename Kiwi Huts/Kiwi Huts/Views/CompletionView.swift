//
//  CompletionView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct CircularProgressView: View {
    
    let hutCount: Double
    let totalHuts: Double
    
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(
                    Color.accentColor.opacity(0.5),
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: hutCount / totalHuts)
                .stroke(
                    Color.accentColor,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
        
        

    }
}

struct RegionProgressView: View {
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 20)
                    .opacity(0.3)
                    .foregroundStyle(Color.accentColor)
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(
                        width: min(progress * geometry.size.width,
                                   geometry.size.width),
                        height: 20
                        )
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}


struct CompletionView: View {
    @EnvironmentObject var user: User
    var hutsList: [Hut]

    // Group huts by region
    var hutsByRegion: [String: [Hut]] {
        Dictionary(grouping: hutsList, by: { $0.region })
    }

    // Calculate progress for each region
    func progress(for region: String) -> CGFloat {
        let hutsInRegion = hutsByRegion[region] ?? []
        let completedHutsInRegion = hutsInRegion.filter { hut in user.completedHuts.contains(where: { $0.id == hut.id }) }
        return CGFloat(completedHutsInRegion.count) / CGFloat(hutsInRegion.count)
    }

    // Calculate the number of completed huts in each region
    var completedHutsInRegion: [String: Int] {
        hutsByRegion.mapValues { hutsInRegion in
            hutsInRegion.filter { hut in user.completedHuts.contains(where: { $0.id == hut.id }) }.count
        }
    }

    var body: some View {
        NavigationView {
                ScrollView {
                    ZStack {
                        
                        CircularProgressView(hutCount: Double(user.completedHuts.count), totalHuts: Double(hutsList.count))
                            .frame(width: 200, height: 200)
                            .padding()
                        
                        Text("\(Int(user.completedHuts.count)) / \(Int(hutsList.count)) \nHuts")
                            .font(.title)
                            .bold()
                        
                        
                    }
                    
                    Spacer()
                    
                    // Sort the regions
                    
                    let sortedRegions = hutsByRegion.keys.sorted { regionA, regionB in
                        let progressA = progress(for: regionA)
                        let progressB = progress(for: regionB)
                        return progressA > progressB
                    }
                    
                    // Create a regionProgressView for each region
                    ForEach(sortedRegions, id: \.self) { region in
                        NavigationLink(destination: RegionListView(huts: hutsList.filter { hut in hut.region == region && user.completedHuts.contains(where: { $0.id == hut.id }) }, region: region)) {
                            VStack {
                                HStack {
                                    Text(region)
                                        .font(.headline)
                                        .foregroundStyle(Color.primary)
                                    Spacer()
                                    Text("\(completedHutsInRegion[region] ?? 0) / \(hutsByRegion[region]?.count ?? 0)")
                                        .font(.headline)
                                        .foregroundStyle(Color.primary)
                                }
                                RegionProgressView(progress: progress(for: region))
                                    .frame(height: 30)
                            }
                            .padding(.horizontal, 50)
                        }
                    }
            }
                .navigationTitle("Completion")
        }
    }
}


struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy user and hutsList for the preview
        let dummyHut = Hut(id: "1", name: "Hut1", status: "OPEN", region: "Region1", y: 1, x: 1, locationString: nil, numberOfBunks: nil, facilities: nil, hutCategory: "Standard", proximityToRoadEnd: nil, bookable: false, introduction: "Introduction", introductionThumbnail: "Thumbnail", staticLink: "Link", place: nil, lon: 1.0, lat: 1.0)
        let hutsList = [dummyHut, dummyHut, dummyHut, dummyHut, dummyHut]

        CompletionView(hutsList: hutsList)
            .environmentObject(User(completedHuts: [dummyHut, dummyHut, dummyHut], savedHuts: [dummyHut, dummyHut, dummyHut]))
    }
}
