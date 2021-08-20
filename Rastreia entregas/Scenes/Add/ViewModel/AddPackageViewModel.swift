//
//  AddPackageViewModel.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 16/08/21.
//

import CoreData

class AddPackageViewModel: AddPackageViewDelegate {

    private let context: NSManagedObjectContext
    var name: String = ""
    var code: String = ""

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func savePackage() {
        let newPackage = Package(context: context)

        newPackage.name = name
        newPackage.code = code

        do {
            try context.save()
        } catch {}
    }
}
