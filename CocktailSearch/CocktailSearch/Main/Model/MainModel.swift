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

struct SectionMainModel {
    var headerTitle: String
    var items: [Item]
}

extension SectionMainModel: SectionModelType {
    typealias Item = MainModel

    init(original: SectionMainModel, items: [MainModel]) {
        self = original
        self.items = items
    }
}
