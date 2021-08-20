//
//  UILabel.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 11/08/21.
//

import UIKit

extension UILabel {
    convenience init(fontStyle: UIFont.Style, textColor: UIColor) {
        self.init(frame: CGRect())
        self.font = .REDesignSystem(font: fontStyle)
        self.textColor = textColor
    }
}
