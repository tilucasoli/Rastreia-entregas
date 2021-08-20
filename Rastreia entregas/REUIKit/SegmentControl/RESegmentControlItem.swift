//
//  RESegmentControlItem.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 29/07/21.
//

import UIKit

// swiftlint:disable identifier_name

protocol RESegmentControlItemDelegate: AnyObject {
    func itemDidTap(index: Int)
}

class RESegmentControlItem: UIView {

    // MARK: Properties
    private let id: Int
    let title: String
    var disabledColor: UIColor = .RELightBlue
    var highlightedColor: UIColor = .REBlue

    weak var delegate: RESegmentControlItemDelegate?

    var isHighlighted = false {
        didSet {
            backgroundColor = isHighlighted ? highlightedColor : disabledColor
        }
    }

    // MARK: UI Elements
    private lazy var titleLabel: UILabel = .init(fontStyle: .heading6, textColor: .white)

    // MARK: Life Cycle
    init(id: Int, title: String) {
        self.id = id
        self.title = title
        super.init(frame: CGRect())

        titleLabel.text = title
        layer.cornerRadius = 4

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
        backgroundColor = disabledColor
        buildHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    func buildHierarchy() {
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    // MARK: Action
    @objc func tapAction() {
        delegate?.itemDidTap(index: id)
    }
}
