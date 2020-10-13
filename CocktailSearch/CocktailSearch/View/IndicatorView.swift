//
//  IndicatorView.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/13.
//

import UIKit
import RxSwift
import RxCocoa

class IndicatorView: UIView {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "IndicatorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView ?? UIView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    func active(_ value :Bool ) {
        self.isHidden = !value
        value ? indicatorView.startAnimating() : indicatorView.stopAnimating()
    }
}


extension Reactive where Base: IndicatorView {

    var isActive: Binder<Bool> {
        return Binder(self.base) { view, bool in
            view.active(bool)
        }
    }
}
