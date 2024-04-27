//
//  getHuts.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 27/04/24.
//

import Foundation

func getHuts() {
    let url = URL(string: "https://api.doc.govt.nz/v2/huts?coordinatess=wgs84")
    let request = URLRequest(url: url)

    let headers = ["x-api-key": apiKey] // Implement API KEY secret
    request.setValue("\(apiKey)", forHTTPHeaderField: "x-api-key")

}


/*
func performAPICall() async throws -> Question {
	let url = URL(string: "https://api.stackexchange.com/2.3/questions?pagesize=1&order=desc&sort=votes&site=stackoverflow&filter=)pe0bT2YUo)Qn0m64ED*6Equ")!
	let (data, _) = try await URLSession.shared.data(from: url)
	let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
	return wrapper.items[0]
}
*/