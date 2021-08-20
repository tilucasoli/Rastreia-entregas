//
//  RETableViewHeader.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 30/07/21.
//

import UIKit

class RETableViewHeader: UITableViewHeaderFooterView {

    // MARK: Properties
    static let reuseId = "RETableViewHeader"

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    // MARK: UI Elements
    private let titleLabel: UILabel = .init(fontStyle: .heading5, textColor: .REGray1)

    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .REGray3
        return view
    }()

    // MARK: Life Cycle
    init() {
        super.init(reuseIdentifier: nil)
        contentView.backgroundColor = .REGray4

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
