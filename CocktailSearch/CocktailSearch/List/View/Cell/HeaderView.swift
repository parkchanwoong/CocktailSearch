//
//  HeaderView.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/16.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView, Resuable {

    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var contentsView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static var height: CGFloat {
        return 44
    }
}
