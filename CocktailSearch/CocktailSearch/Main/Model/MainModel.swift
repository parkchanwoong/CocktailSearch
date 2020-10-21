//
//  MainModel.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/20.
//

import Foundation
import UIKit
import RxDataSources

struct MainModel {
    var title: String
    var height: CGFloat
}

struct RxMainModel {
    var items: [Item]
}

extension RxMainModel: SectionModelType {
    typealias Item = MainModel

    init(original: RxMainModel, items: [MainModel]) {
        self = original
        self.items = items
    }
}
