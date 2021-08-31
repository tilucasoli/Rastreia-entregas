//
//  UIFonts.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 09/07/21.
//

import UIKit

// RE = Rastreia Entregas
public extension UIFont {
    private enum FontName: String {
        // Font: Lexend
        case lexendThin = "Lexend-Thin"
        case lexendLight = "Lexend-Light"
        case lexendRegular = "Lexend-Regular"
        case lexendMedium = "Lexend-Medium"
        case lexendSemiBold = "Lexend-SemiBold"
        case lexendBold = "Lexend-Bold"
        case lexendExtraBold = "Lexend-ExtraBold"

        // Font: Inter
        case interThin = "Inter-Thin"
        case interLight = "Inter-Light"
        case interRegular = "Inter-Regular"
        case interMedium = "Inter-Medium"
        case interSemiBold = "Inter-SemiBold"
        case interBold = "Inter-Bold"
        case interExtraBold = "Inter-ExtraBold"
        case interBlack = "Inter-Black"
        case interExtraLight = "Inter-ExtraLight"
    }

    enum Style {
        case heading4
        case heading5
        case heading6

        case smallTextRegular
    }

    static func REDesignSystem(font: Style) -> UIFont {
        switch font {
        case .heading4:
            return UIFont(name: FontName.lexendSemiBold.rawValue, size: 28)!
        case .heading5:
            return UIFont(name: FontName.lexendSemiBold.rawValue, size: 20)!
        case .heading6:
            return UIFont(name: FontName.lexendSemiBold.rawValue, size: 16)!
        case .smallTextRegular:
            return UIFont(name: FontName.interRegular.rawValue, size: 14)!
        }
    }

}
