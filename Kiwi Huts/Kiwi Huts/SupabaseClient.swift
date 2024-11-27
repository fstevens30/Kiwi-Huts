//
//  SupabaseClient.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 27/11/2024.
//

import Foundation

struct SupabaseClient {
    static let baseURL = "https://utlkldneoqomzffvenps.supabase.co"
    static let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV0bGtsZG5lb3FvbXpmZnZlbnBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1ODc4NzMsImV4cCI6MjA0ODE2Mzg3M30.MbtD6mUCWedv9uY1OCvRTn_DScQHSQ3NOUautJ3FKOU"
    
    static func fetchHuts(completion: @escaping (Result<[Hut], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rest/v1/huts") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
                return
            }

            do {
                let huts = try JSONDecoder().decode([Hut].self, from: data)
                completion(.success(huts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
