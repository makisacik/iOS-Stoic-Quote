//
//  SavedQuotesTableViewCell.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 24.10.2021.
//

import UIKit

protocol SavedQuotesCellDelegate {
    func deleteTheQuote(quote:Quote)
}

class SavedQuotesTableViewCell: UITableViewCell {

    var delegate : SavedQuotesCellDelegate?
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        copyButton.tintColor = .init(red: 130/255, green: 124/255, blue: 119/255, alpha: 1)
        deleteButton.tintColor = .init(red: 130/255, green: 124/255, blue: 119/255, alpha: 1)
    }
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            self.copyButton.alpha = 0.2
            self.copyButton.alpha = 1
        } completion: { [weak self] _ in
            UIPasteboard.general.string = self?.quoteLabel.text
        }
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            self.quoteLabel.alpha = 0.2
            self.quoteLabel.alpha = 1
            
            self.authorLabel.alpha = 0.2
            self.authorLabel.alpha = 1

            self.deleteButton.alpha = 0.3
            self.deleteButton.alpha = 1
            
        } completion: { [self] (finished:Bool)  in
            if let qArr = quotesArr{
                for index in 0 ..< qArr.count {
                    if(qArr[index].quote == quoteLabel.text){
                        quotesArr?.remove(at: index)
                        delegate?.deleteTheQuote(quote: qArr[index])
                        break;
                    }
                }
            }
        }

        
    }
    
    func getCurrentQuote() -> String{
        return quoteLabel.text ?? "";
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
