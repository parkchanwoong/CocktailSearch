//
//  MainViewModel.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/07.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import NSObject_Rx
import RxDataSources

class MainViewModel: CommonViewModel, HasDisposeBag {

    let dataSource: RxTableViewSectionedReloadDataSource<SectionMainModel> = {
        let ds = RxTableViewSectionedReloadDataSource<SectionMainModel>(configureCell: { dataSource, tableView, index, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: NormalTableViewCell.identifier, for: index) as! NormalTableViewCell
            cell.configure(item)
            return cell
        })

        ds.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].headerTitle
        }
        return ds
    }()



    var drinkName = PublishSubject<String>()
    var imageName = PublishSubject<String>()

    var sectionMainModelSubject = PublishSubject<[SectionMainModel]>()

    /// 통신중을 나타내는 옵저버블 변수
    var isNetworking = BehaviorRelay<Bool>(value: false)

    var getDateAction: CocoaAction {
        return CocoaAction { [weak self] _ in
            guard let self = self else { return Observable<Void>.just(())}
            self.isNetworking.accept(true)
            Network.shared.getRandomCocktailUsingRxAlamofire()
                .subscribe(onNext: { [weak self] value in
                    guard let self = self else { return }
                    guard let drink = value?.drinks?.first else { return }
                    let sectionModels = [SectionMainModel(headerTitle: "Category", items: [MainModel(title: drink.strCategory ?? "", height: 44)]),
                                         SectionMainModel(headerTitle: "Alcoholic", items: [MainModel(title: drink.strAlcoholic ?? "", height: 44)]),
                                         SectionMainModel(headerTitle: "Glass", items: [MainModel(title: drink.strGlass ?? "", height: 44)]),
                                         SectionMainModel(headerTitle: "Instruction", items: [MainModel(title: drink.strInstructions ?? "", height: 44)])]
                    self.drinkName.onNext(drink.strDrink ?? "")
                    self.imageName.onNext(drink.strDrinkThumb ?? "")
                    self.sectionMainModelSubject.onNext(sectionModels)
                })
                .disposed(by: self.disposeBag)

            return Observable<Void>.just(())
        }
    }

}

