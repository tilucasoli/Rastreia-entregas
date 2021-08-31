//
//  Styleable.swift
//  Rastreia entregas
//
//  Created by Lucas Oliveira on 13/07/21.
//

import Foundation

protocol Styleable {
    associatedtype Styles: RawRepresentable

    func applyStyle(_ style: Styles)
}
