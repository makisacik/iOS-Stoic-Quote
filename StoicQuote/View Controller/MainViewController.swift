//
//  MainViewController.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 16.10.2021.
//

import UIKit
import CoreData
import Network

let monitor = NWPathMonitor()


class MainViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    
    @IBOutlet var mainView: UIView!
    
    @IBAction func copyButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.copyButton.alpha = 0.2
            self.copyButton.alpha = 1
        } completion: { [weak self] _ in
            UIPasteboard.general.string = self?.quoteLabel.text
        }
    }
    
    @IBAction func saveButonPressed(_ sender: UIButton) {
        if saveButton.imageView?.image == UIImage(systemName: "bookmark.fill") {
            UIView.animate(withDuration: 0.3) {
                self.saveButton.alpha = 0.3
                self.saveButton.alpha = 1
                self.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
            deleteQuote()
        }
        else{
            saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveQuote()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        quotesArr = []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(mainSwiped(_:)))
        gestureSwipeRecognizer.direction = .left
        gestureSwipeRecognizer.numberOfTouchesRequired = 1
        mainView.addGestureRecognizer(gestureSwipeRecognizer)
        mainView.isUserInteractionEnabled = true
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        getQuote()
        
    }
    
    @objc func mainSwiped(_ gesture:UISwipeGestureRecognizer){
        getQuote()
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
    
    
    private func getQuote(){
        if(NetworkManager.shared.isConnected){
            UIView.animate(withDuration: 0.2) {
                self.quoteLabel.alpha = 0.5
                self.authorLabel.alpha = 0.5
            }
            let url = URL(string: "https://api.themotivate365.com/stoic-quote")
            
            let session = URLSession(configuration: .default)
            
            let urlRequest = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            
            let task = session.dataTask(with: urlRequest) { (data:Data?, response:URLResponse?, error:Error?) in
                if let err = error {
                    print(err.localizedDescription)
                }
                self.parseJSON(data: data!)
            }
            task.resume()
        } 
        else{
            print("Connection error")
            self.quoteLabel.text = "Connection Error \n Please Check Your Internet Connection"
            self.authorLabel.text = ""
        }
        
    }
    
    func parseJSON(data:Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MainData.self, from: data)
            let quoteData = decodedData.data
            DispatchQueue.main.async {
                self.updateLabels(author: quoteData.author, quote: quoteData.quote)
            }
        } catch {
            print(error)
            quoteLabel.text = "Error loading the quote , check your internet connection"
        }
        
    }
        
     private func updateLabels(author: String, quote: String){
        var newQuote = quote
        var newAuthor = author
        
        if newQuote.last == "@" {
            newQuote.removeLast()
        }
        if newAuthor == ""{
            newAuthor = "Anonym"
        }
        authorLabel.text = newAuthor
        quoteLabel.text = newQuote
        
        UIView.animate(withDuration: 0.15) {
            self.quoteLabel.alpha = 0.1
            self.authorLabel.alpha = 0.1
            self.quoteLabel.alpha = 1
            self.authorLabel.alpha = 1
        }
        
    }
    
    
    func saveQuote(){
        let currentQuote = Quote(context: context)
        currentQuote.author = authorLabel.text
        currentQuote.quote = quoteLabel.text
        if quotesArr != nil{
            quotesArr!.append(currentQuote)
        }
        do {
            try context.save()
        } catch{
            print("Error on saving data \(error)")
        }
        
    }
    
    func deleteQuote(){
        if let qArr = quotesArr{
            for index in 0 ..< qArr.count {
                if(qArr[index].quote == quoteLabel.text){
                    quotesArr?.remove(at: index)
                    context.delete(qArr[index])
                    do {
                        try context.save()
                    } catch  {
                        print("Error deleting \(error)")

                    }
                    break;
                }
            }
        }
    }
    
}
