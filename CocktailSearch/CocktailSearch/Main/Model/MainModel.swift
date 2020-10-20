//
//  MainModel.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/20.
//

import Foundation
import UIKit
import RxDataSources

enum HeaderType: String {
    case none
    case image
    case category
    case alcoholic
    case glass
    case instructions

    var size: CGSize {
        switch self {
        case .none: return .zero
        case .image: return CGSize(width: UIScreen.main.bounds.width, height: 300)
        case .category, .alcoholic, .glass, .instructions: return CGSize(width: UIScreen.main.bounds.width, height: 30)
        }
    }
}

struct MainHeaderModel: Equatable {
    let type: HeaderType
    var value: String
}
extension MainHeaderModel: IdentifiableType {
    var identity: Double {
        return Date().timeIntervalSinceReferenceDate
    }
}

enum CellType: Int {
    case category
    case alcoholic
    case glass
    case instructions

    var size: CGSize {
        switch self {
        default:
            return CGSize(width: UIScreen.main.bounds.width, height: 44)
        }
    }
}

struct MainModel: Equatable {
    let type: CellType
    var title: String
}
extension MainModel: IdentifiableType {
    var identity: Double {
        return Date().timeIntervalSinceReferenceDate
    }
}
