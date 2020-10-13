//
//  RandomCocktail.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/07.
//

struct RandomCocktail: Codable {
    let drinks: [Items]?

    struct Items: Codable {
        let idDrink: String?
        let strDrink: String?
        let strDrinkThumb: String?
    }
}
