//
//  DetailCardViewController.swift
//  CardList
//
//  Created by Артем Хрещенюк on 14.05.2021.
//

import UIKit

class DetailCardViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    private var visaColor = #colorLiteral(red: 0.9803921569, green: 0.6666666667, blue: 0.07450980392, alpha: 1)
    private var masterCardColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    
    var cardModel: CardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settings()
    }
    
    func settings() {
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        
        setData()
    }
    
    func setData() {
        guard let imageName = cardModel?.cardType.rawValue else {return}
        guard let cardNumber = cardModel?.cardNumber else {return}
        cardTypeImageView.image = UIImage(named: imageName)
        cardNumberLabel.text = getShortCardNumber(number: cardNumber)
        
        switch cardModel?.cardType {
        case .masterCard:
            cardView.backgroundColor = masterCardColor
        default:
            cardView.backgroundColor = visaColor
        }
    }
    
    func getShortCardNumber(number: String) -> String {
        var result = String()
        for (number, value) in number.enumerated() {
            switch number {
            case 10...13:
                result += "*"
            case 14:
                result += " "
            case 15...:
                result += String(value)
            default:
                break
            }
        }
        return result
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.layoutSubviews()
    }
}
