//
//  Package+CoreDataProperties.swift
//  
//
//  Created by Lucas Oliveira on 26/08/21.
//
//

import Foundation
import CoreData

extension Package {

    static var counter: Int32 = 1

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Package> {
        return NSFetchRequest<Package>(entityName: "Package")
    }

    public override func didSave() {
        super.didSave()
        id = Package.counter
        Package.counter += 1
    }

    @NSManaged public var code: String?
    @NSManaged private(set) var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var wasDelivered: Bool

}
