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

typealias SectionModel = AnimatableSectionModel<MainHeaderModel, MainModel>

class MainViewModel: CommonViewModel, HasDisposeBag {
    let dataSource: RxTableViewSectionedAnimatedDataSource<SectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<SectionModel> (configureCell: { (datasource, tableView, index, item) -> UITableViewCell in
            switch item.type {
            case .category, .alcoholic , .glass, .instructions:
                let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: index) as! NormalTableViewCell
                cell.title.text = item.title
                return cell
            }
        })

        return ds
    }()



    var contentsBehaviorSubject = BehaviorSubject<Void>(value: ())
//    var contentsData: Driver<[SectionModel]> {
//        return contentsBehaviorSubject
//            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .flatMap { _ in Network.shared.getRandomCocktailUsingRxAlamofire()}
//            .map { ( value ) -> [SectionModel] in
//                var sectionList = [SectionModel]()
//                return sectionList
//            }
//    }

    var drinkName = PublishSubject<String>()
    var imageName = PublishSubject<String>()

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
                    self.drinkName.onNext(drink.strDrink ?? "")
                    self.imageName.onNext(drink.strDrinkThumb ?? "")
                })
                .disposed(by: self.disposeBag)

            return Observable<Void>.just(())
        }
    }

}

