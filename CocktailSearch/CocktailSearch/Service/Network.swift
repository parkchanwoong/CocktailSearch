//
//  Network.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/07.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

enum Api {
    case random
    case cocktailDetail(String)
    
    var url: String {
        switch self {
        case .random:
            return "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        case .cocktailDetail(let cocktailId):
            return "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(cocktailId)"
        }
    }
}

class Network {
    static let shared = Network()
    static let alamofire: Alamofire.Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.headers = HTTPHeaders.default
        configuration.timeoutIntervalForRequest = 5
        return Alamofire.Session(configuration: configuration)
    }()
    
    private init() { }
    
    func getRandomCocktailUsingRxAlamofire() -> Observable<CocktailInfo?> {
        return Network.alamofire.rx
            .responseData(.get, Api.random.url)
            .map {try JSONDecoder().decode(CocktailInfo.self, from: $0.1)}
            .catchErrorJustReturn(nil)
    }

    func cocktailInfo(id: String) -> Observable<CocktailInfo?> {
        return Network.alamofire.rx
            .responseData(.get, Api.cocktailDetail(id).url)
            .map {try JSONDecoder().decode(CocktailInfo.self, from: $0.1)}
            .catchErrorJustReturn(nil)
    }
}
