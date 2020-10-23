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
    private var lastContentOffset: CGFloat = 0

    private var indicatorView: IndicatorView!
    private var stretchyTableHeaderView: StretchyTableHeaderView!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var getCocktailButton: UIButton!
    @IBOutlet weak var cocktailButtonBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()


        self.indicatorView = IndicatorView.instanceFromNib() as? IndicatorView
        stretchyTableHeaderView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 350))

        self.tableView.tableHeaderView = stretchyTableHeaderView
        self.view.addSubview(indicatorView)


        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        tableView.register(NormalTableViewCell.nib, forCellReuseIdentifier: NormalTableViewCell.identifier)
        
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
                self.navigationItem.title = value?.strDrink ?? ""
                self.stretchyTableHeaderView.imageView.kf.setImage(with: URL(string: value?.strDrinkThumb ?? ""), completionHandler: { _ in
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

        let temp = [SectionMainModel(headerTitle: "Category", items: [MainModel(title: "맥주", height: 55), MainModel(title: "양주", height: 100), MainModel(title: "소주", height: 55)]),
                    SectionMainModel(headerTitle: "Alcoholic",items: [MainModel(title: "맥주", height: 55), MainModel(title: "양주", height: 100), MainModel(title: "소주", height: 55)]),
                    SectionMainModel(headerTitle: "Glass",items: [MainModel(title: "맥주", height: 55), MainModel(title: "양주", height: 100), MainModel(title: "소주", height: 55)]),
                    SectionMainModel(headerTitle: "Instruction",items: [MainModel(title: "맥주", height: 55), MainModel(title: "양주", height: 100), MainModel(title: "소주", height: 55)])]

        Observable.just(temp)
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)


        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] index in
                self.tableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: rx.disposeBag)

//        viewModel.drinkName
//            .bind(to: productLabel.rx.text)
//            .disposed(by: rx.disposeBag)

//        viewModel.imageName
//            .map { URL(string: $0)}
//            .subscribe(onNext: { [unowned self] value in
//                self.productImageView.kf.setImage(with: value, completionHandler:  { _ in
//                    viewModel.isNetworking.accept(false)
//                })
//            })
//            .disposed(by: rx.disposeBag)

        initialNetworking()

    }

}
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.dataSource[indexPath.section].items[indexPath.row].height
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.layoutIfNeeded()
        stretchyTableHeaderView.scrollViewDidScroll(scrollView: scrollView)

        if lastContentOffset < scrollView.contentOffset.y {
            self.cocktailButtonBottomConstraint.constant = -TabBarViewController.barHeight
        } else {
            self.cocktailButtonBottomConstraint.constant = 10
        }
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }
}
