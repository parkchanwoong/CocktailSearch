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
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "headerView")
        tableView.delegate = self
        tableView.dataSource = self
    }


    func bindViewModel() {

    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell else { return UITableViewCell() }

        cell.itemLabel.text = "셀 번호 :: \(indexPath.row)"


        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let v = UIView()
        let v = HeaderView(reuseIdentifier: "headerView")
        v.backgroundColor = .yellow
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


private class HeaderView: UITableViewHeaderFooterView {

    static var height: CGFloat {
        return 44
    }
    var segmented: UISegmentedControl = {
        let s = UISegmentedControl(items: ["Alchole","NonAlchole"])
        return s
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.translatesAutoresizingMaskIntoConstraints = false
        segmented.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(segmented)
        segmented.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        segmented.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        segmented.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        segmented.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.translatesAutoresizingMaskIntoConstraints = false
//        segmented.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(segmented)
//        segmented.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        segmented.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        segmented.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        segmented.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
