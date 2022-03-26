//
//  SavedQuotesViewController.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 24.10.2021.
//

import UIKit
import CoreData

var quotesArr : [Quote]?


class SavedQuotesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource , SavedQuotesCellDelegate{

    
    @IBOutlet weak var savedQuotesTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        loadQuote()
        
    }
    
    var cellQuoteVC : SavedQuotesTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Saved Quotes"
        savedQuotesTable.reloadData()
        savedQuotesTable.dataSource = self
        savedQuotesTable.delegate = self
        

        savedQuotesTable.register(UINib(nibName: "SavedQuotesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        savedQuotesTable.autoresizingMask = .flexibleHeight
        savedQuotesTable.backgroundColor = UIColor(red: 247/255, green: 237/255, blue: 226/255, alpha: 1)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arr = quotesArr else{
            return 0
        }
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SavedQuotesTableViewCell
        cell.authorLabel.text = quotesArr![indexPath.row].author
        cell.quoteLabel.text = quotesArr![indexPath.row].quote
        cell.deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        cell.delegate = self
        cell.autoresizingMask = .flexibleHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                deleteQuote(q: quotesArr![indexPath.row])
                quotesArr!.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
    
    
    @objc func didTapDeleteButton(_ sender:UIButton){
    }
    
    func deleteTheQuote(quote:Quote){
        deleteQuote(q: quote)
        savedQuotesTable.reloadData()
    }
    
    func loadQuote() {
        let request:NSFetchRequest<Quote> = Quote.fetchRequest()
        do {
            quotesArr = try context.fetch(request)
            quotesArr?.reverse()
        } catch  {
            print("Error fetching data \(error)")
        }
    }
    
    func deleteQuote(q : Quote){
        
        context.delete(q)
        do {
            try context.save()
        } catch  {
            print("Error deleting \(error)")

        }
    }

}


