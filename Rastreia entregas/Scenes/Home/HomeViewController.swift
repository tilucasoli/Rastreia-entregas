//
//  HomeViewController.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 05/07/21.
//

import UIKit

class HomeViewController: UIViewController, PackageProviding, Networking {

    lazy var network: Networking = self

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = HomeViewModel(service: self)
        // Do any additional setup after loading the view.
    }


}

