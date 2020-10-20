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
    private var stretchyTableHeaderView: StretchyTableHeaderView!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var getCocktailButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()


        self.indicatorView = IndicatorView.instanceFromNib() as? IndicatorView
        stretchyTableHeaderView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 350))

        self.tableView.tableHeaderView = stretchyTableHeaderView
        self.view.addSubview(indicatorView)


        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        
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
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell ?? UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        stretchyTableHeaderView.scrollViewDidScroll(scrollView: scrollView)
    }
}
