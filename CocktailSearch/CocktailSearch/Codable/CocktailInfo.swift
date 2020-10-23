//
//  CocktailInfo.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/15.
//

struct CocktailInfo: Codable {
    let drinks: [Items]?

    struct Items: Codable {
        let idDrink: String?
        let strDrink: String?
        let strDrinkThumb: String?
        let strCategory: String?
        let strAlcoholic: String?
        let strGlass: String?
        let strInstructions: String?
    }
}
