//
//  RETextField.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 09/07/21.
//

import UIKit

public class RETextField: UITextField {

    // MARK: Constants

    private let insetText: (x: CGFloat, y: CGFloat) = (x: 12, y: 0)

    // MARK: Properties

    public let heightStyle: HeightStyle

    public override var placeholder: String? {
        didSet {
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.REGray2]
            attributedPlaceholder = .init(string: placeholder ?? "", attributes: attributes)
        }
    }

    // MARK: Life Cycle

    public init(style: HeightStyle) {
        heightStyle = style
        super.init(frame: CGRect())
        setupLayout()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(heightStyle.rawValue)
        }
    }

    public func setupLayout() {
        backgroundColor = .REGray3

        font = .REDesignSystem(font: .smallTextRegular)
        textColor = .REGray1

        layer.cornerRadius = 4
    }

    // MARK: Overrides

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let discontToCentralize = bounds.width - (2 * insetText.x)
        return CGRect(x: insetText.x, y: 0, width: discontToCentralize, height: bounds.height)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let discontToCentralize = bounds.width - (2 * insetText.x)
        return CGRect(x: 12, y: 0, width: discontToCentralize, height: bounds.height)
    }
}

extension RETextField {

    public enum HeightStyle {
        case standard
        case custom(value: Int)

        var rawValue: Int {
            switch self {
            case .standard:
                return 44
            case .custom(let value):
                return value
            }
        }
    }

}
