//
//  ListViewModel.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/14.
//

import Foundation
import RxSwift
import RxCocoa

struct AlcoholInfo {
    var id: String = ""
    var productName: String = ""
    var productImageName: String = ""
}

class ListViewModel {

    let disposeBag = DisposeBag()

//    var rxdata = PublishSubject<[AlcoholInfo]>()
//    var items = [AlcoholInfo]()

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

//    func getData() -> Observable<[AlcoholInfo]> {
//        Network.shared.getAlcoholNonAlcohol(alcoholicType: AlcoholicType.alcoholic)
//            .map {$0?.drinks}
//            .map { [weak self] drinks in
//                guard let drinks = drinks else { return [AlcoholInfo]()}
//                guard let self = self else { return [AlcoholInfo]()}
//                for drink in drinks {
//                    var item = AlcoholInfo()
//                    item.id = drink.idDrink ?? ""
//                    item.productName = drink.strDrink ?? ""
//                    item.productImageName = drink.strDrinkThumb ?? ""
//                    self.items.append(item)
//                }
//                self.rxdata.onNext(self.items)
//                return self.items
//            }.catchErrorJustReturn([AlcoholInfo]())
//    }

}
