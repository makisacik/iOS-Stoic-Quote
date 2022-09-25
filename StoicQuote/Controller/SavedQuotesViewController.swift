//
//  SavedQuotesViewController.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 24.10.2021.
//

import UIKit
import CoreData

class SavedQuotesViewController: UIViewController {

    @IBOutlet weak var savedQuotesTable: UITableView! {
        didSet {
            savedQuotesTable.dataSource = self
            savedQuotesTable.delegate = self
            savedQuotesTable.register(UINib(nibName: String(describing: SavedQuoteTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SavedQuoteTableViewCell.self))
            savedQuotesTable.backgroundColor = ColorConstants.lightBackgroundColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoreDataManager.shared.loadQuotes()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Saved Quotes"
        view.backgroundColor = ColorConstants.lightBackgroundColor
    }
}

extension SavedQuotesViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let savedQuotes = savedQuotes else{
            return 0
        }
        return savedQuotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SavedQuoteTableViewCell.self), for: indexPath) as! SavedQuoteTableViewCell
        if let savedQuotes = savedQuotes {
            cell.setup(quote: savedQuotes[indexPath.row])
        }
        cell.delegate = self
        cell.autoresizingMask = .flexibleHeight

        return cell
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let savedQuotes = savedQuotes {
                CoreDataManager.shared.deleteQuote(quoteId: Int(savedQuotes[indexPath.row].id))
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension SavedQuotesViewController: SavedQuoteTableViewCellDelegate{
    func reloadSavedQuoteTableView() {
        savedQuotesTable.reloadData()
    }
}


