//
//  CoreDataManager.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 21.09.2022.
//

import Foundation
import CoreData
import UIKit

var savedQuotes : [SavedQuote]?

class CoreDataManager {

    static let shared = CoreDataManager()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveQuote(currentQuote: Quote?) {
        if let currentQuote = currentQuote {
            if quoteExists(quoteId: currentQuote.id) {
                return
            }

            let quote = SavedQuote(context: context)
            if let author = currentQuote.author, let body = currentQuote.body, let id = currentQuote.id {
                quote.author = author
                quote.quote = body
                quote.id = Int32(id)
            }

            if var savedQuotes = savedQuotes {
                savedQuotes.append(quote)
            }
            saveContext()
            loadQuotes()
        }
    }

    func quoteExists(quoteId: Int?) -> Bool {
        if let savedQuotes = savedQuotes, let quoteId = quoteId {
            for savedQuote in savedQuotes {
                if savedQuote.id == quoteId {
                    return true
                }
            }
        }
        return false
    }

    func deleteQuote(quoteId: Int?) {
        loadQuotes()
        if let quoteId = quoteId {
            if let savedQuotes = savedQuotes{
                for index in 0 ..< savedQuotes.count {
                    if savedQuotes[index].id == quoteId {
                        context.delete(savedQuotes[index])
                        saveContext()
                        loadQuotes()
                        return
                    }
                }
            }
        }
    }

    func loadQuotes() {
        let request:NSFetchRequest<SavedQuote> = SavedQuote.fetchRequest()
        do {
            savedQuotes = try context.fetch(request)
            savedQuotes?.reverse()
        } catch  {
            print("Error fetching data \(error)")
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error on saving data \(error)")
        }
    }

}

