import SwiftUI
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
    
    func fetchHutsFromSupabase() {
        guard let url = URL(string: "\(SupabaseClient.baseURL)/rest/v1/huts") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(SupabaseClient.apiKey, forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching huts: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let huts = try JSONDecoder().decode([Hut].self, from: data)
                print("Decoded huts: \(huts.count)")
                DispatchQueue.main.async {
                    self.hutsList = huts
                    self.updateLastUpdated()
                }
            } catch {
                print("Error decoding huts: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON: \(jsonString)")
                }
            }
        }.resume()
    }
    
    // Save huts to UserDefaults
    private func saveHutsLocally(huts: [Hut]) {
        if let encoded = try? JSONEncoder().encode(huts) {
            UserDefaults.standard.set(encoded, forKey: localHutsKey)
        }
    }
    
    // Update last updated timestamp
    public func updateLastUpdated() {
        guard let url = URL(string: "\(SupabaseClient.baseURL)/rest/v1/timestamps?select=timestamp&order=timestamp.desc&limit=1") else {
            print("Invalid URL for timestamps")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(SupabaseClient.apiKey, forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching latest timestamp: \(error)")
                return
            }

            guard let data = data else {
                print("No data returned from Supabase")
                return
            }

            do {
                if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let latestTimestamp = result.first?["timestamp"] as? String { // Adjusted to match column name
                    print("Raw timestamp string: \(latestTimestamp)")

                    // Adjusted to handle fractional seconds (e.g., 2024-11-27T21:49:04.405348)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS" // Format with fractional seconds
                    formatter.timeZone = TimeZone(secondsFromGMT: 0)

                    if let parsedDate = formatter.date(from: latestTimestamp) {
                        DispatchQueue.main.async {
                            self.lastUpdated = parsedDate
                            print("Last updated timestamp set to: \(self.lastUpdated!)")
                        }
                    } else {
                        print("Failed to parse the timestamp: \(latestTimestamp)")
                    }
                } else {
                    print("Failed to parse JSON structure")
                }
            } catch {
                print("Error decoding JSON: \(error)")
                print("Response as string: \(String(data: data, encoding: .utf8) ?? "nil")")
            }
        }.resume()
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
            viewModel.fetchHutsFromSupabase()
            viewModel.updateLastUpdated()
        } else {
            viewModel.loadHutsLocally()
        }
        
        networkMonitor.$isConnected.sink { isConnected in
            if isConnected {
                viewModel.fetchHutsFromSupabase()
            } else {
                viewModel.loadHutsLocally()
            }
        }.store(in: &cancellables)
    }
    
    @State private var cancellables = Set<AnyCancellable>()
}
