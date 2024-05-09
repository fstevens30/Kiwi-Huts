//
//  Kiwi_HutsApp.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import SwiftUI
import Firebase
import Network

class HutsViewModel: ObservableObject {
    @Published var hutsList = [Hut]()

    // Add a method to fetch huts if needed
    func fetchHutsIfNeeded() {
        if hutsList.isEmpty {
            fetchHutsFromFirestore()
        }
    }

    // Fetch huts from Firestore and update the hutsList
    func fetchHutsFromFirestore() {
        let db = Firestore.firestore()
        db.collection("huts").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            var huts = [Hut]()
            for document in snapshot!.documents {
                do {
                    let hut = try document.data(as: Hut.self)
                    huts.append(hut)
                } catch {
                    print("Error decoding document: \(document.documentID), \(error)")
                }
            }
            DispatchQueue.main.async {
                self?.hutsList = huts
                print("Fetched huts count: \(huts.count)")
            }
        }
    }
}

// Monitoring Network Connectivity
class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    @Published var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}


@main
struct Kiwi_HutsApp: App {
    @StateObject var user = User(completedHuts: [], savedHuts: [])
    @StateObject var viewModel = HutsViewModel()
    @StateObject var networkMonitor = NetworkMonitor()
    
    // Network monitor for checking internet connectivity
    private let monitor = NWPathMonitor()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(user)
                .environmentObject(viewModel)
                .environmentObject(networkMonitor)
                .onAppear() {
                    FirebaseApp.configure()
                    loadInitialData()
                    monitorNetwork()
                }
        }
    }

    // Initial data loading based on network availability
    private func loadInitialData() {
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                self.viewModel.fetchHutsFromFirestore()
            } else {
                self.loadHutsLocally()
            }
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }

    // Network monitoring to handle connectivity changes
    private func monitorNetwork() {
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                self.viewModel.fetchHutsFromFirestore()
            } else {
                self.loadHutsLocally()
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    // Load huts from UserDefaults
    func loadHutsLocally() {
        print("Attempting to load huts locally")
        if let savedHuts = UserDefaults.standard.object(forKey: "localHuts") as? Data {
            if let loadedHuts = try? JSONDecoder().decode([Hut].self, from: savedHuts) {
                DispatchQueue.main.async {
                    self.viewModel.hutsList = loadedHuts
                    print("Loaded huts locally, count: \(loadedHuts.count)")
                }
            } else {
                print("Failed to decode huts from UserDefaults")
            }
        } else {
            print("No local data found in UserDefaults")
        }
    }

    // Save huts to UserDefaults
    private func saveHutsLocally(huts: [Hut]) {
        if let encoded = try? JSONEncoder().encode(huts) {
            UserDefaults.standard.set(encoded, forKey: "localHuts")
        }
    }
}
