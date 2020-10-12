//
//  SceneCoordinator.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/07.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {


    private let bag = DisposeBag()

    private var window: UIWindow
    private var currentVC: UIViewController

    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animation: Bool) -> Completable {
        let subject = PublishSubject<Void>()

        let target = scene.instantiate()

        switch style {
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
        case .push:
            guard let nav = currentVC.navigationController else { subject.onError(TransotionError.navigationControllerMissing)
                break
            }
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] evt in
                    self.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: bag)

            nav.pushViewController(target, animated: animation)
            currentVC = target.sceneViewController
            subject.onCompleted()

        case .modal:
            currentVC.present(target, animated: animation) {
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
        }
        
        return subject.ignoreElements()
    }

    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in

            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransotionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransotionError.unknown))
            }
            return Disposables.create()
        }
    }

}
