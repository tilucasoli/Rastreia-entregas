//
//  AddPackageViewModel.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 16/08/21.
//

import CoreData
import Services

protocol AddPackageViewModelDelegate: AnyObject {
    func checkingCodeValidation(_ isValid: Bool)
}

class AddPackageViewModel: AddPackageViewDelegate {

    private let context: NSManagedObjectContext

    private var isValidCode = false {
        didSet {
            delegate?.checkingCodeValidation(isValidCode)
        }
    }

    var name: String = ""
    var code: String = ""
    weak var delegate: AddPackageViewModelDelegate?

    init() {
        self.context = PackageRepository.shared.container.viewContext
    }

    func savePackage() {
        let newPackage = Package(context: context)

        newPackage.name = name
        newPackage.code = code
        newPackage.wasDelivered = false

        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func checkIfPackageWorks(code: String) {
        let provider = PackageProviding()
        provider.getPackage(code: code) {[weak self] result in
            switch result {
            case .success(_):
                self?.isValidCode = true
            case .failure(let error):
                print(error)
                self?.isValidCode = false
            }
        }
    }
}
