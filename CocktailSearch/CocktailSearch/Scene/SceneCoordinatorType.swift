//
//  SceneCoordinatorType.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/07.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animation: Bool) -> Completable

    @discardableResult
    func close(animated: Bool) -> Completable
}
