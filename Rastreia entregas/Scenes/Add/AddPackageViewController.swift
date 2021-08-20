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

        guard let context = getContext() else {
            return
        }

        addPackageViewModel = AddPackageViewModel(context: context)
        addPackageView.delegate = addPackageViewModel
    }

    private func configureClousures() {
        addPackageView.dismiss = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }

    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer().viewContext

    }

}
