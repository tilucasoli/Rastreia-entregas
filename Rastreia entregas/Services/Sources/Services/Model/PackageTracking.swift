//
//  PackageTracking.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 05/07/21.
//

import Foundation

// MARK: - PackageTracking
public struct PackageTracking: Codable {
    public let codigo, servico, host: String
    public let quantidade: Int
    public let eventos: [Evento]
    public let time: Double
    public let ultimo: String
}

// MARK: - Evento
public struct Evento: Codable {
    public let data, hora, local, status: String
    public let subStatus: [String]
}
