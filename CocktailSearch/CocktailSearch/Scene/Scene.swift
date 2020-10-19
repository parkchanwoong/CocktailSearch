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
    case detail(DetailViewModel)
}

extension Scene {
    func instantiate() -> UIViewController {
        
        switch self {

        case .tabbar(let viewControllers):
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabbarVC") as? TabBarViewController else { fatalError() }
            tabbarVC.viewControllers = viewControllers
            return tabbarVC

        case .main(let viewModel):
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard var mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainViewController else { fatalError() }
            mainVC.bind(viewModel: viewModel)
            return mainVC

        case .list(let viewModel):
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let navi = storyboard.instantiateViewController(withIdentifier: "ListNavi") as? UINavigationController else { fatalError() }
            guard var listVC = navi.viewControllers.first as? ListViewController else { fatalError() }
            listVC.bind(viewModel: viewModel)
            return navi

        case .detail(let viewModel):
            let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { fatalError() }
            detailVC.bind(viewModel: viewModel)
            return detailVC
        }

    }
}
