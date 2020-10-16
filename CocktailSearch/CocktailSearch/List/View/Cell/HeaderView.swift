//
//  HeaderView.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/16.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib  {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var segmented: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static var height: CGFloat {
        return 44
    }
//    var segmented: UISegmentedControl = {
//        let s = UISegmentedControl(items: ["Alchole","NonAlchole"])
//        return s
//    }()

}
