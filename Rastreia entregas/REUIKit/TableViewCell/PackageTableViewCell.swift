//
//  PackageTableViewCell.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 16/08/21.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

    // MARK: Properties
    static let reuseId = "RETableViewHeader"

    private(set) var packageCard: PackageCard?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .REGray4
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public APIs
    func configurePackageCard(packageCard: PackageCard) {
        self.packageCard = packageCard
        useViewAsContent(packageCard, with: .init(top: 16, left: 0, bottom: 0, right: 0))
    }

}
