//
//  HeaderView.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/16.
//

import UIKit
import RxDataSources

class HeaderModel: Equatable, IdentifiableType {
    static func == (lhs: HeaderModel, rhs: HeaderModel) -> Bool {
        return lhs.identity == rhs.identity
    }

    var identity: String
    var height: CGFloat

    init(identity: String, height: CGFloat) {
        self.identity = identity
        self.height = height
    }
}

class HeaderView: UITableViewHeaderFooterView, Resuable {

    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var contentsView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
