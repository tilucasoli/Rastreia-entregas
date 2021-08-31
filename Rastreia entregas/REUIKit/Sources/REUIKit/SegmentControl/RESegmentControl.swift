//
//  RESegmentControl.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 29/07/21.
//

import UIKit

// MARK: Delegate
public protocol RESegmentControlDelegate: AnyObject {
    func indexDidChange(index: Int)
}

// MARK: Styleable
extension RESegmentControl: Styleable {
    public typealias Styles = StylesSegmentControl

    public enum StylesSegmentControl: Int {
        case expanded
        case compacted
    }

    public func applyStyle(_ style: StylesSegmentControl) {
        switch style {
        case .expanded:
            buildLayoutExpanded()
        case .compacted:
            buildLayoutCompacted()
        }
    }
}

public class RESegmentControl: UIView {

    // MARK: Constants
    private let height = 52

    // MARK: Properties

    public var selectedSegmentIndex: Int = 0 {
        didSet {
            delegate?.indexDidChange(index: selectedSegmentIndex)
        }
    }

    weak var delegate: RESegmentControlDelegate?

    public var style: Styles = .compacted {
        didSet {
            applyStyle(style)
        }
    }

    private var segmentItems = [RESegmentControlItem]() {
        didSet {
            for segmentItem in segmentItems {
                stackView.addArrangedSubview(segmentItem)
            }
        }
    }

    // MARK: UI Elements
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        let icon = UIImage.icAdjustment?.withTintColor(.white)
        imageView.image = icon
        imageView.contentMode = .center
        imageView.backgroundColor = .REBlue
        imageView.layer.cornerRadius = 4
        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    private let auxiliarView = UIView()

    // MARK: Life Cycle
    public init(segments: [String]) {
        super.init(frame: CGRect())

        addSegmentItems(segments)

        buildHierarchy()
        setupConstraints()
        buildStackViewSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        applyStyle(style)
    }

    // MARK: Layout
    private func addSegmentItems(_ segments: [String]) {
        for index in 0..<segments.count {
            let segmentItem = RESegmentControlItem(id: index, title: segments[index])
            segmentItem.delegate = self
            segmentItems.append(segmentItem)
        }
    }

    private func buildLayoutCompacted() {
        stackView.arrangedSubviews.forEach {$0.isHidden = true}
        iconImageView.isHidden = false
        auxiliarView.isHidden = true
    }

    private func buildLayoutExpanded() {
        stackView.arrangedSubviews.forEach {$0.isHidden = false}
        iconImageView.isHidden = true

        segmentItems[selectedSegmentIndex].isHighlighted = true
    }

    private func buildStackViewSubviews() {
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(auxiliarView)
    }

    private func buildHierarchy() {
        addSubview(stackView)
    }

    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(height)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RESegmentControl: RESegmentControlItemDelegate {
    public func itemDidTap(index: Int) {
        segmentItems.forEach {$0.isHighlighted = false}
        segmentItems[index].isHighlighted = true
        selectedSegmentIndex = index
    }
}
