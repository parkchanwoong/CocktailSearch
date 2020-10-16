//
//  Reuseable.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/16.
//

import Foundation
import UIKit

protocol Resuable: class {
    static var identifier: String { get }
    static var nib: UINib { get }
    static var nibName: String { get }
}

extension Resuable {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    static var nibName: String {
        guard let name = String(describing: self).components(separatedBy: ".").last else { return "" }
        return name
    }
}
