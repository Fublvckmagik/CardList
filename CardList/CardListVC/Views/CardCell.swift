//
//  CardCell.swift
//  CardList
//
//  Created by Артем Хрещенюк on 14.05.2021.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    var cardModel: CardModel? {
        didSet {
            guard let imageName = cardModel?.cardType.rawValue else {return}
            guard let cardNumber = cardModel?.cardNumber else {return}
            cardTypeImageView.image = UIImage(named: imageName)
            cardNumberLabel.text = secureText(cardNumber: cardNumber)
        }
    }
    
    func secureText(cardNumber: String) -> String {
        var result = String()
        
        for (number, value) in cardNumber.enumerated() {
            if value != " " {
                if number > 14 {
                    result += String(value)
                } else {
                    result += "*"
                }
            } else {
                result += String(value)
            }
        }
        return result
    }
}
