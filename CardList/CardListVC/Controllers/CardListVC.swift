//
//  ViewController.swift
//  CardList
//
//  Created by Артем Хрещенюк on 14.05.2021.
//

import UIKit

class CardListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cardlistModel = CardListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings()
    }

    @IBAction func addCardAction(_ sender: UIBarButtonItem) {
        actionSheet()
    }
    
    func settings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        navigationItem.title = AppText.navigationTitle.rawValue
    }
    
    func actionSheet() {
        let alert = UIAlertController(title: AppText.selectCardType.rawValue, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: CardType.visa.rawValue, style: .default, handler: { (_) in
            let newCard = CardModel(cardType: CardType.visa, cardNumber: self.cardlistModel.generateCardNumber())
            self.cardlistModel.cards.insert(newCard, at: 0)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: CardType.masterCard.rawValue, style: .default, handler: { (_) in
            let newCard = CardModel(cardType: CardType.masterCard, cardNumber: self.cardlistModel.generateCardNumber())
            self.cardlistModel.cards.insert(newCard, at: 0)
            self.tableView.reloadData()
        }))
        present(alert, animated: true)

    }
}

extension CardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardlistModel.cards.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CardCell
        guard let customCell = cell else { return UITableViewCell() }
        
        customCell.cardModel = cardlistModel.cards[indexPath.row]
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cardlistModel.cards[indexPath.row]
        performSegue(withIdentifier: "cardDetails", sender: card)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardDetails" {
            let dvc = segue.destination as? DetailCardViewController
            guard let card = sender as? CardModel else {return}
            dvc?.cardModel = card
        }
    }
}
