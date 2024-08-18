//
//  APIClient.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 18/08/24.
//

import Combine
import Foundation

struct APIClient {
    
    private let urlString = "https://run.mocky.io/v3/f5a55b84-ed24-48e0-b757-6802c214f591"
    
    func fetchLayout() -> AnyPublisher<APIResponse, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: urlString)!)
            .map( { $0.data })
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
