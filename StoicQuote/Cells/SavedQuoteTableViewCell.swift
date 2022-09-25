import UIKit

protocol SavedQuoteTableViewCellDelegate: AnyObject{
    func reloadSavedQuoteTableView()
}

class SavedQuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    weak var delegate : SavedQuoteTableViewCellDelegate?

    var quote: SavedQuote? {
        didSet {
            quoteLabel.text = quote?.quote
            authorLabel.text = quote?.author
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        copyButton.tintColor = ColorConstants.lightButtonColor
        deleteButton.tintColor = ColorConstants.lightButtonColor
    }

    func setup(quote: SavedQuote){
        self.quote = quote
    }

    @IBAction func copyButtonPressed(_ sender: UIButton) {
        copyButton.fadeInOut()
        UIPasteboard.general.string = quoteLabel.text
    }

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        quoteLabel.fadeInOut()
        authorLabel.fadeInOut()
        deleteButton.fadeInOut()

        CoreDataManager.shared.deleteQuote(quoteId: Int(quote?.id ?? 0))
        delegate?.reloadSavedQuoteTableView()
    }

}
