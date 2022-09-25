import UIKit

class AboutStoicismViewController: UIViewController {

    @IBOutlet weak var whatIsLabel: UILabel!

    @IBOutlet weak var theWordLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        whatIsLabel.text = "Stoicism teaches the development of self-control and fortitude as a means of overcoming destructive emotions;\nthe philosophy holds that becoming a clear and unbiased thinker allows one to understand the universal reason."

        theWordLabel.text = "The word refers to someone who is indifferent to pain, pleasure, grief, or joy. The modern usage as a \"person who represses feelings or endures patiently\" was first cited in 1579 as a noun and in 1596 as an adjective. In contrast to the term \"Epicurean\", the Stanford Encyclopedia of Philosophy's entry on Stoicism notes, \"the sense of the English adjective 'stoical' is not utterly misleading with regard to its philosophical origins."
    }
}
