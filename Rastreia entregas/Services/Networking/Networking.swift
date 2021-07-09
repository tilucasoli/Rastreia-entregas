//
//  Networking.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 06/07/21.
//

import Foundation

protocol Networking {
    func get<T: Decodable>(_ endpoint: URL, completion: @escaping (Result<T, Error>) -> Void) 
}

extension Networking {
    func get<T: Decodable>(_ endpoint: URL, completion: @escaping (Result<T, Error>) -> Void) {

        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data...")
                }

                let decodedObject = try JSONDecoder().decode(T.self, from: data)

                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }


}
