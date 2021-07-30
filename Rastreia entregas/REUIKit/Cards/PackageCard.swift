//
//  PackageCard.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 14/07/21.
//

import UIKit

enum DeliveryStatus {
    case packing, sent, onRoute, delivered

    func getImageSettings() -> (image: UIImage?, backgroundColor: UIColor) {
        switch self {
        case .packing:
            let image = UIImage.icPacking?.withTintColor(.REGray2)
            return (image: image, backgroundColor: .REGray3)
        case .sent:
            let image = UIImage.icShippingBox?.withTintColor(.REBlue)
            return (image: image, backgroundColor: .RELightBlue)
        case .onRoute:
            let image = UIImage.icOnRoute?.withTintColor(.REYellow)
            return (image: image, backgroundColor: .RELightYellow)
        case .delivered:
            let image = UIImage.icPackageDelivered?.withTintColor(.REGreen)
            return (image: image, backgroundColor: .RELightGreen)

        }
    }
}

class PackageCard: UIView {

    // MARK: Properties

    var icon: DeliveryStatus {
        didSet {
            configureImageView()
        }
    }
    var title: String? {
        didSet {
            titleLabel.text = title

            let shouldHide = title == nil || title == ""
            titleLabel.isHidden = shouldHide
            emptyView.isHidden = !shouldHide

        }
    }
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
            subtitleLabel.text = subtitleLabel.text?.uppercased()
            subtitleLabel.isHidden = subtitle == nil || subtitle == ""
        }
    }

    // MARK: UI Elements

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .center
        return imageView
    }()

    private lazy var stackTitles: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .REGray1
        label.font = .REDesignSystem(font: .heading6)
        label.isHidden = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .REGray2
        label.font = .REDesignSystem(font: .smallTextRegular)
        label.isHidden = true
        return label
    }()

    private lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .REGray3
        view.layer.cornerRadius = 4
        return view
    }()

    // MARK: Life Cycle

    init(icon: DeliveryStatus) {
        self.icon = icon
        super.init(frame: CGRect())

        configureImageView()
        buildHierarchy()
        buildStackViewSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    private func configureImageView() {
        let imageSettings = icon.getImageSettings()
        imageView.image = imageSettings.image
        imageView.backgroundColor = imageSettings.backgroundColor
    }

    private func buildHierarchy() {
        addSubview(imageView)
        addSubview(stackTitles)
        addSubview(emptyView)
    }

    private func buildStackViewSubviews() {
        stackTitles.addArrangedSubview(titleLabel)
        stackTitles.addArrangedSubview(subtitleLabel)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(44)
        }
        stackTitles.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).inset(-12)
            make.right.equalToSuperview()
            make.height.centerY.equalTo(imageView)
        }
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(120)
            make.left.centerY.equalTo(stackTitles)
        }
    }
}
