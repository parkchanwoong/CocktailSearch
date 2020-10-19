//
//  ListViewModel.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/14.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import Action

struct AlcoholInfo {
    var id: String = ""
    var productName: String = ""
    var productImageName: String = ""
}

typealias HeaderViewModel = AnimatableSectionModel<Int, HeaderModel>

class ListViewModel: CommonViewModel {

    override init(sceneCoordinator: SceneCoordinatorType) {
        super.init(sceneCoordinator: sceneCoordinator)
    }

    let disposeBag = DisposeBag()

    let datasource: RxTableViewSectionedAnimatedDataSource<HeaderViewModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<HeaderViewModel>(configureCell: {
            (datasource, tableView, indexPath, item) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }

            return cell
        })

        return ds
    }()

    var alcoholInfo: Driver<[AlcoholInfo]> {
        return Network.shared.getAlcoholNonAlcohol(alcoholicType: AlcoholicType.alcoholic)
            .map { $0?.drinks }
            .map { drinks in
                guard let drinks = drinks else { return []}
                var alcohoinfo = [AlcoholInfo]()
                for drink in drinks {
                    var item = AlcoholInfo()
                    item.id = drink.idDrink ?? ""
                    item.productName = drink.strDrink ?? ""
                    item.productImageName = drink.strDrinkThumb ?? ""
                    alcohoinfo.append(item)
                }
                return alcohoinfo
            }
            .asDriver(onErrorJustReturn: [])
    }

    lazy var detailAction: Action<AlcoholInfo,Void> = {
        return Action { info in
            let viewModel = DetailViewModel(sceneCoordinator: self.sceneCoordinator)
            let scene = Scene.detail(viewModel)
            return self.sceneCoordinator.transition(to: scene, using: .push, animation: true).asObservable().map { _ in }
        }
    }()
}
