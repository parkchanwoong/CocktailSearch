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
import Kingfisher

class MainViewController: UIViewController, ViewModelBindableType {
    var viewModel: MainViewModel!

    private var indicatorView: IndicatorView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var getCocktailButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()


        self.indicatorView = IndicatorView.instanceFromNib() as? IndicatorView
        self.view.addSubview(indicatorView)
        
        self.indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.indicatorView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.indicatorView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true

        indicatorView.isHidden = true
    }

    private func initialNetworking() {
        self.viewModel.isNetworking.accept(true)
        Network.shared.getRandomCocktailUsingRxAlamofire()
            .map { $0?.drinks?.first}
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.productLabel.text = value?.strDrink
                self.productImageView.kf.setImage(with: URL(string: value?.strDrinkThumb ?? ""), completionHandler: { _ in
                    self.viewModel.isNetworking.accept(false)
                })
            })
            .disposed(by: rx.disposeBag)
    }

    func bindViewModel() {

        getCocktailButton.rx.action = viewModel.getDateAction

        viewModel.isNetworking
            .bind(to: indicatorView.rx.isActive)
            .disposed(by: rx.disposeBag)

        viewModel.drinkName
            .bind(to: productLabel.rx.text)
            .disposed(by: rx.disposeBag)

        viewModel.imageName
            .map { URL(string: $0)}
            .subscribe(onNext: { [unowned self] value in
                self.productImageView.kf.setImage(with: value, completionHandler:  { _ in
                    viewModel.isNetworking.accept(false)
                })
            })
            .disposed(by: rx.disposeBag)

        initialNetworking()

    }

}
