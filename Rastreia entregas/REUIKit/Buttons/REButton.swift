//
//  REButton.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 14/07/21.
//

import UIKit

// MARK: Styleable Protocol

extension REButton: Styleable {
    typealias Styles = ButtonStyle

    enum ButtonStyle: Int {
        case primary
        case ghost
    }

    enum Size {
        case medium
        case large

        func getSize() -> CGSize {
            switch self {
            case .medium:
                return CGSize(width: 44, height: 44)
            case .large:
                return CGSize(width: 52, height: 52)
            }
        }
    }

    func applyStyle(_ style: ButtonStyle) {
        switch style {
        case .ghost:
            backgroundColor = .clear
            layer.cornerRadius = 4
        case .primary:
            layer.cornerRadius = 4
        }
    }
}

class REButton: UIButton {
    let size: Size
    let style: REButton.ButtonStyle

    init(style: REButton.ButtonStyle, size: Size) {
        self.style = style
        self.size = size
        super.init(frame: CGRect())

        configureSize(size)
        applyStyle(style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSize(_ size: Size) {
        snp.makeConstraints { make in
            make.height.equalTo(size.getSize().height)
            make.width.equalTo(size.getSize().width)
        }
    }
}
