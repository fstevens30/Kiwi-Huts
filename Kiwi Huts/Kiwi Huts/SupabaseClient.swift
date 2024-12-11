//
//  SupabaseClient.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 27/11/2024.
//

import Foundation

struct SupabaseClient {
    static let baseURL: String = {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("BASE_URL not found in Info.plist")
        }
        print(baseURL)
        return baseURL
    }()

    static let apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return apiKey
    }()
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
