//
//  EnvironmentVariables.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 03/08/21.
//

import Foundation

public struct EnvironmentVariables {
    public static let token = ProcessInfo.processInfo.environment["API_TOKEN_CORREIOS"]
    public static let email = ProcessInfo.processInfo.environment["API_EMAIL_CORREIOS"]
}
