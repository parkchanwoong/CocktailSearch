//
//  MainViewController.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/07.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MainViewController: UIViewController, ViewModelBindableType {
    var viewModel: MainViewModel!

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var getCocktailButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func bindViewModel() {
        getCocktailButton.rx.action = viewModel.getDateAction
        
        viewModel.drinkName
            .bind(to: productLabel.rx.text)
            .disposed(by: rx.disposeBag)

//        viewModel
//            .drinkDriver
//            .drive(productLabel.rx.text)
//            .disposed(by: rx.disposeBag)
    }

}
