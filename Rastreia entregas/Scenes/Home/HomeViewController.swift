//
//  HomeViewController.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 05/07/21.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    let segmentControl = RESegmentControl(segments: ["A caminho", "Arquivados"])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        view.addSubview(segmentControl)
        segmentControl.style = .expanded

        segmentControl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(327)
        }
    }

}
