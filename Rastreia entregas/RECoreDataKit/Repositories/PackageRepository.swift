//
//  PackageRepository.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 19/08/21.
//

import UIKit
import CoreData

class PackageRepository: GenericRepository {
    typealias GenericObject = Package

    private(set) var container: NSPersistentContainer
    static var shared = PackageRepository()

    // MARK: INIT
    // TODO: Refazer a parte do appDelegate
    private init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.container = appDelegate?.persistentContainer() ?? AppDelegate().persistentContainer()
    }

    // MARK: PUBLIC APIs
    func create() -> Package {
        return Package(context: container.viewContext)
    }

    func get(predicate: CoreDataPredicate? = nil,
             sortDescriptors: [NSSortDescriptor]? = nil) -> Result<[Package], Error> {

        let request: NSFetchRequest<Package> = Package.fetchRequest()
        request.predicate = predicate?.getNSPredicate()
        do {
            let packageFetched = try container.viewContext.fetch(request)
            return.success(packageFetched)
        } catch {
            return .failure(error)
        }
    }

    func delete(object: Package) -> Result<Bool, Error> {
        container.viewContext.delete(object)
        return .success(true)
    }
}
