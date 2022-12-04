//
//  MainViewController.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 16.10.2021.
//

import UIKit
import CoreData
import Network

class MainViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet var mainView: UIView!

    var currentQuote: Quote?

    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(mainSwiped(_:)))
        gestureSwipeRecognizer.direction = .left
        gestureSwipeRecognizer.numberOfTouchesRequired = 1

        mainView.addGestureRecognizer(gestureSwipeRecognizer)
        mainView.isUserInteractionEnabled = true
        saveButton.setImageBookmark()
        getQuote()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.loadQuotes()

        if CoreDataManager.shared.quoteExists(quoteId: currentQuote?.id) {
            saveButton.setImageBookmarkFill()
        } else {
            saveButton.setImageBookmark()
        }
    }

    private func getQuote() {
        if NetworkManager.shared.isConnected {
            NetworkManager.shared.getRandomQuote { [self] results in
                switch results {
                case .success(let result):
                    let quote = result
                    currentQuote = quote
                    updateLabels()

                case .failure(let failure):
                    print(failure)
                }
            }
        } else {
            self.quoteLabel.text = "Connection Error \n Please Check Your Internet Connection"
            self.authorLabel.text = ""
        }
    }

    private func updateLabels() {
        authorLabel.text = currentQuote?.author
        quoteLabel.text = currentQuote?.body

        quoteLabel.fadeInOut(fadeInDuration: 0.15, fadeOutDuration: 0.03)
        authorLabel.fadeInOut(fadeInDuration: 0.15, fadeOutDuration: 0.03)
    }

    @objc func mainSwiped(_ gesture:UISwipeGestureRecognizer) {
        getQuote()
        saveButton.setImageBookmark()
    }

    @IBAction func copyButtonPressed(_ sender: UIButton) {
        copyButton.fadeInOut()
        UIPasteboard.general.string = self.quoteLabel.text
    }

    @IBAction func saveButonPressed(_ sender: UIButton) {
        if saveButton.imageView?.image == UIImage(systemName: "bookmark.fill") {
            self.saveButton.setImageBookmark()
            CoreDataManager.shared.deleteQuote(quoteId: currentQuote?.id)
        } else {
            saveButton.setImageBookmarkFill()
            CoreDataManager.shared.saveQuote(currentQuote: currentQuote)
        }
    }

}
