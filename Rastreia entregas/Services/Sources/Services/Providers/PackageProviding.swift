//
//  PackageProviding.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 06/07/21.
//

import Foundation

// MARK: Protocol
public protocol PackageProvidingProtocol {
    var network: Networking { get }
    func getPackage(code: String, _ completion: @escaping (Result<PackageTracking, Error>) -> Void)

}

// MARK: Implementation
public class PackageProviding: PackageProvidingProtocol {

    public var network: Networking = Networking.shared

    let baseLinkeTrackURL: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.linketrack.com"
        return components
    }()

    public init(network: Networking = Networking.shared) {
        self.network = network
    }

    public func getPackage(code: String, _ completion: @escaping (Result<PackageTracking, Error>) -> Void) {
        var rootURL = self.baseLinkeTrackURL

        rootURL.path = "/track/json"

        let token = EnvironmentVariables.token ?? ""
        let email = EnvironmentVariables.email ?? ""

        let queryItemUser = URLQueryItem(name: "user", value: email)
        let queryItemToken = URLQueryItem(name: "token", value: token)
        let queryItemCode = URLQueryItem(name: "codigo", value: code)

        rootURL.queryItems = [queryItemUser, queryItemToken, queryItemCode]

        guard let url = rootURL.url else {return}

        network.get(url, completion: completion)
    }
}
