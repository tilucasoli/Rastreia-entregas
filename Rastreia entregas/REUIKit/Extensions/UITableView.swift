//
//  UITableView.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 19/07/21.
//

import UIKit

extension UITableViewCell {
    func useViewAsContent(_ view: UIView, with edge: UIEdgeInsets) {
        contentView.addSubview(view)

        view.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(edge.top)
            make.left.equalToSuperview().inset(edge.left)
            make.right.equalToSuperview().inset(edge.right)
            make.bottom.equalToSuperview().inset(edge.bottom)
        }
    }
}
