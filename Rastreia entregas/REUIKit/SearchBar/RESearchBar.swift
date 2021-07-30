//
//  RESearchBar.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 19/07/21.
//

import UIKit
import SnapKit

class RESearchBar: UIView {

    // MARK: Constants

    private let height = 52

    // MARK: Properties

    var isHighlighted = false {
        didSet {
            UIView.animate(withDuration: 0.2, animations: {
                self.isHighlighted ? self.buildLayoutExpanded() : self.buildLayoutCompacted()
            }, completion: {[weak self] _ in
                self?.textField.becomeFirstResponder()
            })
        }
    }

    // MARK: UI Elements

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        let icon = UIImage.icSearch?.withTintColor(.REBlue)
        imageView.image = icon
        imageView.contentMode = .center
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 4
        return imageView
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .REGray3
        view.layer.cornerRadius = 1
        return view
    }()

    private lazy var textField: RETextField = {
        let textField = RETextField(style: .custom(value: height))
        textField.backgroundColor = .white
        return textField
    }()

    private let auxiliarView = UIView()

    // MARK: Life Cycle

    init() {
        super.init(frame: CGRect())

        layer.cornerRadius = 4
        layer.masksToBounds = true

        buildHierarchy()
        setupConstraints()
        buildStackViewSubviews()

        buildLayoutCompacted()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    private func buildLayoutCompacted() {
        separator.isHidden = true
        textField.isHidden = true
        auxiliarView.isHidden = false

        textField.layer.cornerRadius = 0
        iconImageView.layer.cornerRadius = 4
    }

    private func buildLayoutExpanded() {
        separator.isHidden = false
        textField.isHidden = false
        auxiliarView.isHidden = true

        textField.layer.cornerRadius = 0
        iconImageView.layer.cornerRadius = 0
    }

    private func buildHierarchy() {
        addSubview(stackView)
        textField.addSubview(separator)
    }

    private func buildStackViewSubviews() {
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(auxiliarView)
    }

    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(height)
        }

        separator.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        separator.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.width.equalTo(0.8)
        }

    }

}
