//
//  UIView.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 17/08/21.
//

import UIKit

public extension UIView {
    func addDashedBorder(color: UIColor, inset: CGFloat) {
        let realInset: CGFloat = 2.0 * inset
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = CGRect(x: 0, y: 0,
                                   width: shapeRect.width+realInset,
                                   height: shapeRect.height+realInset)
        shapeLayer.position = CGPoint(x: bounds.midX+inset, y: bounds.midY+inset)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4, 4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 8).cgPath

        self.layer.addSublayer(shapeLayer)
    }
}
