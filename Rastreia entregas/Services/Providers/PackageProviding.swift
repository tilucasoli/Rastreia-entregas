//
//  PackageProviding.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 06/07/21.
//

import Foundation

// MARK: Protocol
protocol PackageProvidingProtocol {
    var network: Networking { get }
    func getPackage(code: String, _ completion: @escaping (Result<PackageTracking, Error>) -> Void)

}

// MARK: Implementation
class PackageProviding: PackageProvidingProtocol {
    var network: Networking = Networking.networking

    func getPackage(code: String, _ completion: @escaping (Result<PackageTracking, Error>) -> Void) {

        let token = "307141616b975c810b81d6b5708a68f2850046931efaed75c332e73f35926ddf"
        let email = "tilucasoli@gmail.com"
        let endpoint = "https://api.linketrack.com/track/json?user=\(email)&token=\(token)&codigo=\(code)"

        guard let url = URL(string: endpoint) else {return}

        network.get(url, completion: completion)
    }
}
