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

    func getRandomCocktail() -> Observable<RandomCocktail> {
        return Observable<RandomCocktail>.create({ observer -> Disposable in
            let request = Network.alamofire.request(Api.random.url)
                .validate(statusCode: 200..<300)
                .responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        do {
                            let res = try JSONDecoder().decode(RandomCocktail.self, from: value)
                            observer.onNext(res)
                            observer.onCompleted()
                        } catch {
                            observer.onError("\(error)" as! Error)
                            print("에러")
                        }
                    case.failure(let error):
                        observer.onError("\(error)" as! Error)
                        print(error)
                    }
                }

            return Disposables.create {
                request.cancel()
            }
        })


    }


}
