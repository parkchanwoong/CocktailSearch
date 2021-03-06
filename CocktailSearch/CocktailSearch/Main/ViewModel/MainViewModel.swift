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

class MainViewModel: CommonViewModel, HasDisposeBag {
    
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

