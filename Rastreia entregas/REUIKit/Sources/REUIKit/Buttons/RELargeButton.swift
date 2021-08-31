//
//  RELargeButton.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 12/07/21.
//

import UIKit

// MARK: Styleable Protocol

extension RELargeButton: Styleable {
    public typealias Styles = ButtonStyles

    public enum ButtonStyles: UInt {
        case primary
    }

    public func applyStyle(_ style: RELargeButton.ButtonStyles) {
        switch style {
        case .primary:
            backgroundColor = isEnabled ? .REBlue : .REGray3
            titleLabel?.font = .REDesignSystem(font: .heading6)
            setTitleColor(.REGray4, for: .normal)
            setTitleColor(.REGray2, for: .disabled)
            layer.cornerRadius = 4
        }
    }
}

// MARK: RELargeButton

public class RELargeButton: UIButton {

    public override var isEnabled: Bool {
        didSet {
            applyStyle(style)
        }
    }

    private var style: RELargeButton.ButtonStyles

    public init(style: RELargeButton.ButtonStyles) {
        self.style = style
        super.init(frame: CGRect())
        applyStyle(style)
        configureConstraints()
    }

    private func configureConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
