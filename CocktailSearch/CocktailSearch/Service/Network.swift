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
    
    var url: String {
        switch self {
        case .random:
            return "https://www.thecocktaildb.com/api/json/v1/1/random.php"
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
    
    func getRandomCocktailUsingRxAlamofire() -> Observable<RandomCocktail?> {
        return Network.alamofire.rx
            .responseData(.get, Api.random.url)
            .map {try JSONDecoder().decode(RandomCocktail.self, from: $0.1)}
            .catchErrorJustReturn(nil)
    }
}
