//
//  TransitionModel.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/07.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransotionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
