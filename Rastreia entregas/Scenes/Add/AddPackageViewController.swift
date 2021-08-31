//
//  AddPackageViewController.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 16/08/21.
//

import UIKit
import CoreData

class AddPackageViewController: UIViewController {
    private let addPackageView = AddPackageView()
    private var addPackageViewModel: AddPackageViewModel?

    override func loadView() {
        self.view = addPackageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureClousures()
        addPackageViewModel = AddPackageViewModel()
        addPackageViewModel?.delegate = self
        addPackageView.delegate = addPackageViewModel
    }

    private func configureClousures() {
        addPackageView.dismiss = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

        addPackageView.presentAlert = { [weak self] in
            let alertViewController = UIAlertController(title: "Loading",
                                                        message: "Está carregando",
                                                        preferredStyle: .alert)
            self?.present(alertViewController, animated: true, completion: nil)
        }
    }
}

extension AddPackageViewController: AddPackageViewModelDelegate {
    func checkingCodeValidation(_ isValid: Bool) {
        DispatchQueue.main.async {
            if isValid {
                self.dismiss(animated: true) {
                    self.addPackageViewModel?.savePackage()
                }
            } else {
                self.dismiss(animated: true)
            }
        }
    }

}
