//
//  HomeViewController.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 05/07/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    private let homeViewModel: HomeViewModel

    init() {
        homeViewModel = HomeViewModel(service: .init())
        homeViewModel.refreshTableViewData = homeView.getPackages

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        homeView.delegate = self
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension HomeViewController: HomeViewDelegate {
    func pushViewController() {
        let viewController = AddPackageViewController()
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
}
