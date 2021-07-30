//
//  PackageTracking.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 05/07/21.
//

import Foundation

// MARK: - PackageTracking
struct PackageTracking: Codable {
    let codigo, servico, host: String
    let quantidade: Int
    let eventos: [Evento]
    let time: Double
    let ultimo: String
}

// MARK: - Evento
struct Evento: Codable {
    let data, hora, local, status: String
    let subStatus: [String]
}
