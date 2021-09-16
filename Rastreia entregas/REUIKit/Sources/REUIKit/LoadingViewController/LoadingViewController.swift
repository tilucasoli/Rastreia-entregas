//
//  LoadingViewController.swift
//  
//
//  Created by Lucas Oliveira on 31/08/21.
//

import UIKit
import Lottie

public class LoadingViewController: UIViewController {

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()

    private let animationView: AnimationView = {
        let animationView = AnimationView()
        let url = Bundle.module.url(forResource: "PackageAnimation", withExtension: "json")
        let animation = Animation.named("PackageAnimation", bundle: .module, subdirectory: "", animationCache: nil)

        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        return animationView
    }()

    public init() {
        super.init(nibName: nil, bundle: nil)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        animationView.play()
    }

    private func configureLayout() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(animationView)

        backgroundView.snp.makeConstraints { make in
            make.height.width.equalTo(150)
            make.center.equalToSuperview()
        }

        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
