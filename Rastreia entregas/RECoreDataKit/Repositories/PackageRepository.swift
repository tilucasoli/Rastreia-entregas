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

    private var context: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.context = managedObjectContext
    }

    func create() -> Package {
        return Package(context: context)
    }

    func get(predicate: CoreDataPredicate? = nil,
             sortDescriptors: [NSSortDescriptor]? = nil) -> Result<[Package], Error> {

        let request: NSFetchRequest<Package> = Package.fetchRequest()
        request.predicate = predicate?.getNSPredicate()
        do {
            let packageFetched = try context.fetch(request)
            return.success(packageFetched)
        } catch {
            return .failure(error)
        }
    }

    func delete(object: Package) -> Result<Bool, Error> {
        context.delete(object)
        return .success(true)
    }
}
