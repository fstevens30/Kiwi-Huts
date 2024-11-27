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

    static func fetchHuts(completion: @escaping (Result<[Hut], SupabaseError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/rest/v1/huts") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.apiError(error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let huts = try JSONDecoder().decode([Hut].self, from: data)
                completion(.success(huts))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}

enum SupabaseError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case apiError(String)
}
