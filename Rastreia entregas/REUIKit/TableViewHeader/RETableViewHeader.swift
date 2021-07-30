//
//  RETableViewHeader.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 30/07/21.
//

import UIKit

class RETableViewHeader: UITableViewHeaderFooterView {

    // MARK: UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .REGray1
        label.font = .REDesignSystem(font: .heading6)
        return label
    }()

    private let separatorView: UILabel = {
        let label = UILabel()
        label.textColor = .REGray1
        label.font = .REDesignSystem(font: .heading6)
        return label
    }()

    // MARK: Life Cycle
    init(reuseIdentifier: String) {
        super.init(reuseIdentifier: reuseIdentifier)

        buildHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout
    private func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(separatorView)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(22)
            make.left.equalToSuperview()
        }

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.left.right.equalToSuperview()
        }
    }
}
