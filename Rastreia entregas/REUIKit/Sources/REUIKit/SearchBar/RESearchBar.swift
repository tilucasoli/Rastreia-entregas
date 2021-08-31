//
//  RESearchBar.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 19/07/21.
//

import UIKit

public class RESearchBar: UIView {

    // MARK: Constants

    private let height = 52

    // MARK: Properties

    public var isHighlighted = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.isHighlighted ? self.buildLayoutExpanded() : self.buildLayoutCompacted()
            }
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

    // MARK: Life Cycle

    public init() {
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

        textField.layer.cornerRadius = 0
        iconImageView.layer.cornerRadius = 4
    }

    private func buildLayoutExpanded() {
        separator.isHidden = false
        textField.isHidden = false

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

    // MARK: Actions
    public func clearText() {
        textField.text = .none
        textField.endEditing(true)
    }

}
