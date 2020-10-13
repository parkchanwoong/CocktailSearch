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

class MainViewModel: HasDisposeBag {
    
    var drinkName = PublishSubject<String>()
    var imageName = PublishSubject<String>()


//    var drinkDriver: Driver<String> {
//        return drinkName.asDriver(onErrorJustReturn: "")
//    }

    var getDateAction: CocoaAction {
        return CocoaAction {

            Network.shared.getRandomCocktailUsingRxAlamofire()
                .subscribe(onNext: { [unowned self] value in
                    guard let drink = value?.drinks?.first else { return }
                    self.drinkName.onNext(drink.strDrink ?? "")
                    self.imageName.onNext(drink.strDrinkThumb ?? "")
                })
                .disposed(by: self.disposeBag)

            return Observable<Void>.just(())
        }
    }

}

