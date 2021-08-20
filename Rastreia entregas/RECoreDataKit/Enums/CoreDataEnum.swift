//
//  CoreDataEnum.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 20/08/21.
//

import Foundation

enum CoreDataErrors: Error {
    case objectNotFound
}

enum CoreDataPredicate {
    case wasDelivered(bool: Bool)
    case getSpecificObject(id: Int32)

    func getNSPredicate() -> NSPredicate {
        switch self {
        case .wasDelivered(bool: let bool):
            return NSPredicate(format: "wasDelivered = \(bool.description)")
        case .getSpecificObject(id: let id):
            return NSPredicate(format: "id = \(id.description)")
        }
    }
}
