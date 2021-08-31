//
//  InteractablePackageCard.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 17/08/21.
//

import UIKit
import SnapKit
import REUIKit

class InteractablePackageCard: UIView {

    // MARK: Properties
    private var centerOfPackageCard: CGPoint = .zero

    // MARK: UI Elements
    private lazy var backgroundGrayView: UIView = {
        let view = UIView()
        view.backgroundColor = .REGray3
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var packageCard: PackageCard = {
        let packageCard = PackageCard(icon: .onRoute)
        packageCard.backgroundColor = .white

        packageCard.layer.cornerRadius = 3

        packageCard.layer.shadowOpacity = 0.1
        packageCard.layer.shadowRadius = 16
        packageCard.layer.shadowColor = UIColor.REYellow.cgColor
        packageCard.layer.shadowOffset = CGSize(width: 0, height: 4)

        packageCard.translatesAutoresizingMaskIntoConstraints = false
        return packageCard
    }()

    // MARK: Life Cycle
    init() {
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
        configureLayout()
        configureGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        centerOfPackageCard = packageCard.center
        addDashedBorder(color: .REYellow, inset: 2.0)
    }

    // MARK: Layout

    func configureLayout() {
        layer.cornerRadius = 8
        clipsToBounds = false
    }

    func buildHierarchy() {
        addSubview(backgroundGrayView)
        addSubview(packageCard)
    }

    func setupConstraints() {
        backgroundGrayView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(293)
            make.top.equalTo(self).inset(24)
            make.left.right.equalTo(self).inset(29)
            make.bottom.equalTo(self).inset(36)
        }

        packageCard.snp.makeConstraints { make in
            make.width.equalTo(327)
            make.top.equalTo(backgroundGrayView.snp.top).inset(12)
            make.centerX.equalTo(self)
        }
    }

    // MARK: Gesture
    private func configureGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragAction(_:)))
        packageCard.addGestureRecognizer(panGestureRecognizer)
    }

    @objc private func dragAction(_ sender: UIPanGestureRecognizer) {
        if packageCard.frame.maxX + packageCard.frame.minX > frame.maxX ||
            packageCard.frame.minX + frame.minX < frame.minX ||
            packageCard.frame.maxY + packageCard.frame.minY > frame.maxY ||
            packageCard.frame.minY + frame.minY < frame.minY {
            sender.state = .cancelled
            returnViewToCenter(sender)
            return
        }

        if sender.state == .changed {
            let newX = centerOfPackageCard.x + sender.translation(in: self).x
            let newY = centerOfPackageCard.y + sender.translation(in: self).y

            packageCard.center = CGPoint(x: newX, y: newY)
        } else if sender.state == .ended {
            returnViewToCenter(sender)
        }
    }

    private func returnViewToCenter(_ sender: UIPanGestureRecognizer) {
        let constToBounce: CGFloat = -1.05
        let midX = centerOfPackageCard.x + constToBounce * sender.translation(in: self).x
        let midY = centerOfPackageCard.y + constToBounce * sender.translation(in: self).y

        UIView.animate(withDuration: 0.2, animations: {
            self.packageCard.center = CGPoint(x: midX, y: midY)

        }, completion: {_ in
            UIView.animate(withDuration: 0.2, animations: {
                self.packageCard.center = self.centerOfPackageCard

            }, completion: {_ in
                let haptics = UIImpactFeedbackGenerator(style: .heavy)
                haptics.impactOccurred()
            })
        })
    }

}
