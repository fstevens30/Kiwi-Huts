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
}

@main
struct Kiwi_HutsApp: App {
    @StateObject var user = User(completedHuts: [], savedHuts: [])
    @StateObject var viewModel = HutsViewModel()

    // Network monitor for checking internet connectivity
    private let monitor = NWPathMonitor()

    init() {
        FirebaseApp.configure()
        loadInitialData()
        monitorNetwork()
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(user)
                .environmentObject(viewModel)
        }
    }

    // Initial data loading based on network availability
    private func loadInitialData() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.fetchHutsFromFirestore()
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
                self.fetchHutsFromFirestore()
            } else {
                self.loadHutsLocally()
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    // Fetch huts from Firestore and save locally
    func fetchHutsFromFirestore() {
        let db = Firestore.firestore()
        db.collection("huts").getDocuments { [self] (snapshot, error) in
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
                self.viewModel.hutsList = huts
                print("Fetched huts count: \(huts.count)")
            }
        }
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
