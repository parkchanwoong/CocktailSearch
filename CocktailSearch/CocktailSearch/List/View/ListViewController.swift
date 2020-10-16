//
//  ListViewController.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/14.
//

import UIKit

class ListViewController: UIViewController, ViewModelBindableType {

    var viewModel: ListViewModel!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "리스트"

        tableView.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        viewModel.getData()
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.tableView.reloadData()
            })
            .disposed(by: rx.disposeBag)
    }


    func bindViewModel() {


    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell else { return UITableViewCell() }

        cell.itemLabel.text = viewModel.items[indexPath.row].productName

        let source = viewModel.items[indexPath.row].productImageName
        cell.itemImageView.kf.setImage(with: URL(string: source))
//            = viewModel.items[indexPath.row].productName
//            "셀 번호 :: \(indexPath.row)"


        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let v = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else { return UIView() }
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderView.height
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
