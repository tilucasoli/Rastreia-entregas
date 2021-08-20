//
//  Package+CoreDataProperties.swift
//  
//
//  Created by Lucas Oliveira on 20/08/21.
//
//

import Foundation
import CoreData

extension Package {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Package> {
        return NSFetchRequest<Package>(entityName: "Package")
    }

    @NSManaged public var code: String?
    @NSManaged public var id: Int32
    @NSManaged public var wasDelivered: Bool
    @NSManaged public var name: String?

}
