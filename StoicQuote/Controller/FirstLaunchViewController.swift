//
//  FirstLaunchViewController.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 21.10.2021.
//

import UIKit

class FirstLaunchViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        useLabel.text = "Swipe left to display a new quote \n \n For copying and saving the quote use the buttons below\n\nUse side menu to access the saved quotes"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton.layer.cornerRadius = 10
        popUpView.layer.cornerRadius = 5
    }

    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
