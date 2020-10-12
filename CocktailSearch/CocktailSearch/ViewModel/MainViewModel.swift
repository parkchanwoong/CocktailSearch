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

class MainViewModel {
    
    private var drinkName = PublishSubject<String>()
    private var imageName = PublishSubject<String>()

    var getDateAction: CocoaAction {
        return CocoaAction {
            let data = Network.shared.getRandomCocktail()
        
            print(data)
            return Observable<Void>.just(())
        }
    }
}

