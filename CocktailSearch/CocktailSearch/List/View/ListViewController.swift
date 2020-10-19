//
//  ListViewController.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/14.
//

import UIKit
import RxSwift

class ListViewController: UIViewController, ViewModelBindableType {

    var viewModel: ListViewModel!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "리스트"

        tableView.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }


    func bindViewModel() {
        viewModel.alcoholInfo
            .drive(tableView.rx.items(cellIdentifier: ListTableViewCell.identifier, cellType: ListTableViewCell.self)) { _, element, cell in
                cell.configure(element)
            }
            .disposed(by: rx.disposeBag)

        Observable.zip(tableView.rx.modelSelected(AlcoholInfo.self),tableView.rx.itemSelected)
            .do (onNext: { _, index in
                self.tableView.deselectRow(at: index, animated: true)
            })
            .map { $0.0 }
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx.disposeBag)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let v = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else { return UIView() }
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
