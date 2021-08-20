//
//  GenericRepository.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 19/08/21.
//

import Foundation

protocol GenericRepository {
    associatedtype GenericObject

    func create() -> GenericObject
    func get(predicate: CoreDataPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[GenericObject], Error>
    func delete(object: GenericObject) -> Result<Bool, Error>
}
