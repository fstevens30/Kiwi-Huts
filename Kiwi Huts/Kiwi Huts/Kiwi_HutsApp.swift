import SwiftUI
import Firebase
import FirebaseFirestore
import Network
import Combine

class HutsViewModel: ObservableObject {
    @Published var hutsList = [Hut]()
    @Published var lastUpdated: Date?
    
    private let localHutsKey = "localHuts"
    private let lastUpdatedKey = "lastUpdated"
    
    init() {
        self.lastUpdated = UserDefaults.standard.object(forKey: lastUpdatedKey) as? Date
    }
    
    // Fetch huts from Firestore and update the hutsList
    func fetchHutsFromFirestore() {
        let db = Firestore.firestore()
        db.collection("huts").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents found in Firestore.")
                return
            }
            
            // Map the documents to Hut objects
            let huts: [Hut] = documents.compactMap { document in
                return try? document.data(as: Hut.self)
            }
            
            // Update hutsList on the main thread
            self?.hutsList = huts.shuffled()
            self?.saveHutsLocally(huts: huts)
            self?.updateLastUpdated()
            print("Fetched huts count: \(huts.count)")
        }
    }
    
    // Save huts to UserDefaults
    private func saveHutsLocally(huts: [Hut]) {
        if let encoded = try? JSONEncoder().encode(huts) {
            UserDefaults.standard.set(encoded, forKey: localHutsKey)
        }
    }
    
    // Update last updated timestamp
    private func updateLastUpdated() {
        let now = Date()
        self.lastUpdated = now
        UserDefaults.standard.set(now, forKey: lastUpdatedKey)
    }
    
    // Load huts from UserDefaults
    func loadHutsLocally() {
        print("Attempting to load huts locally")
        if let savedHuts = UserDefaults.standard.object(forKey: localHutsKey) as? Data {
            if let loadedHuts = try? JSONDecoder().decode([Hut].self, from: savedHuts) {
                self.hutsList = loadedHuts.shuffled()
                print("Loaded huts locally, count: \(loadedHuts.count)")
            } else {
                print("Failed to decode huts from UserDefaults")
            }
        } else {
            print("No local data found in UserDefaults")
        }
    }
}

// Monitoring Network Connectivity
class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private var queue = DispatchQueue.global(qos: .background)
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
        checkInitialNetworkStatus()
    }
    
    private func checkInitialNetworkStatus() {
        let path = monitor.currentPath
        DispatchQueue.main.async {
            self.isConnected = path.status == .satisfied
        }
    }
}

@main
struct Kiwi_HutsApp: App {
    @StateObject var user = User(completedHuts: [], savedHuts: [])
    @StateObject var viewModel = HutsViewModel()
    @StateObject var networkMonitor = NetworkMonitor()
    
    init() {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Configure Firestore offline persistence using cacheSettings
        let settings = FirestoreSettings()
        settings.cacheSettings = PersistentCacheSettings()
        Firestore.firestore().settings = settings
        
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(user)
                .environmentObject(viewModel)
                .environmentObject(networkMonitor)
                .onAppear {
                    handleInitialDataLoad()
                }
        }
    }
    
    private func handleInitialDataLoad() {
        if networkMonitor.isConnected {
            viewModel.fetchHutsFromFirestore()
        } else {
            viewModel.loadHutsLocally()
        }
        
        networkMonitor.$isConnected.sink { isConnected in
            if isConnected {
                viewModel.fetchHutsFromFirestore()
            } else {
                viewModel.loadHutsLocally()
            }
        }.store(in: &cancellables)
    }
    
    @State private var cancellables = Set<AnyCancellable>()
}
