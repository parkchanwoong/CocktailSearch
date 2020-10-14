//
//  Scene.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/07.
//

import UIKit

enum Scene {
    case tabbar([UIViewController])
    case main(MainViewModel)
    case list(ListViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)

        switch self {

        case .tabbar(let viewControllers):
            guard let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabbarVC") as? TabBarViewController else { fatalError() }
            tabbarVC.viewControllers = viewControllers
            return tabbarVC

        case .main(let viewModel):
            guard var mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainViewController else { fatalError() }
            mainVC.bind(viewModel: viewModel)
            return mainVC

        case .list(let viewModel):
            guard let navi = storyboard.instantiateViewController(withIdentifier: "ListNavi") as? UINavigationController else { fatalError() }
            guard var listVC = navi.viewControllers.first as? ListViewController else { fatalError() }
            listVC.bind(viewModel: viewModel)
            return navi
        }
    }
}
