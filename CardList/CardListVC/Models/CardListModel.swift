//
//  CardListModel.swift
//  CardList
//
//  Created by Артем Хрещенюк on 14.05.2021.
//

import Foundation

enum CardType: String {
    case visa = "Visa"
    case masterCard = "MasterCard"
}

class CardModel {
    var cardType: CardType
    var cardNumber: String
    
    init(cardType: CardType, cardNumber: String) {
        self.cardType = cardType
        self.cardNumber = cardNumber
    }
    
}

class CardListModel {
    
    var cards = [CardModel]()
    
    func generateCardNumber() -> String {
        var newCardNumber = String()
        for i in 0...18 {
            if i == 4 || i == 9 || i == 14 {
                newCardNumber += " "
            } else {
                newCardNumber += "\(Int.random(in: 0...9))"
            }
        }
        
        print(newCardNumber)
        return newCardNumber
    }
}
