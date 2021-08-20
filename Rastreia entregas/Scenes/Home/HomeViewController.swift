//
//  HomeViewController.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 05/07/21.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()

    override func loadView() {
        homeView.delegate = self
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer().viewContext
        let repository = PackageRepository(managedObjectContext: context)

    }

}

extension HomeViewController: HomeViewDelegate {
    func pushViewController() {
        let viewController = AddPackageViewController()
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
}
