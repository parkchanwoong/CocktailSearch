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

enum AlcoholicType {
    case alcoholic
    case nonAlcholic

    var alcholic: String {
        switch self {
        case .alcoholic:
            return "Alcoholic"
        case .nonAlcholic:
            return "Non_Alcoholic"
        }
    }
}

enum Api {
    case random
    case cocktailDetail(String)
    case filterByAlcoholic(AlcoholicType)

    var url: String {
        switch self {
        case .random:
            return "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        case .cocktailDetail(let cocktailId):
            return "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(cocktailId)"
        case .filterByAlcoholic(let alcohol):
            return "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=\(alcohol)"
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

    func getAlcoholNonAlcohol(alcoholicType: AlcoholicType) -> Observable<CocktailInfo?> {
        return Network.alamofire.rx
            .responseData(.get, Api.filterByAlcoholic(alcoholicType).url)
            .map { try JSONDecoder().decode(CocktailInfo.self, from: $0.1)}
            .catchErrorJustReturn(nil)
    }

}
