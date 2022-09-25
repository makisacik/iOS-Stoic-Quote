//
//  SideMenuViewController.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 14.10.2021.
//

import UIKit
import StoreKit

protocol SideMenuDelegate: AnyObject {
    func closeSideMenu()
}

class SideMenuViewController: UIViewController {

    @IBOutlet weak var sideMenuTableView: UITableView! {
        didSet {
            sideMenuTableView.dataSource  = self
            sideMenuTableView.delegate = self
            sideMenuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "sideMenuTableViewCell")
            sideMenuTableView.tableFooterView = UIView.init(frame: CGRect.zero)
            sideMenuTableView.backgroundColor = ColorConstants.sideMenuBackgroundColor
        }
    }
    
    weak var delegate: SideMenuDelegate?

    enum MenuButtons: String,CaseIterable {
        case home = "Home"
        case savedQuotes = "Saved Quotes"
        case aboutStoicism = "About Stoicism"
        case rateApp = "Rate The App"

        var imageName: String{
            switch self {
            case .home:
                return "house"
            case .savedQuotes:
                return "bookmark"
            case .aboutStoicism:
                return "questionmark"
            case .rateApp:
                return "star"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SideMenuViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuButtons.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sideMenuTableView.dequeueReusableCell(withIdentifier: "sideMenuTableViewCell", for: indexPath)
        cell.textLabel?.text = MenuButtons.allCases[indexPath.row].rawValue
        cell.textLabel?.font = UIFont(name: "System", size: 15)
        cell.textLabel?.textColor = .black
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.imageView?.image = UIImage(systemName: MenuButtons.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .black
        cell.backgroundColor = ColorConstants.sideMenuBackgroundColor
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 40)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = sideMenuTableView.cellForRow(at: indexPath)
        sideMenuTableView.deselectRow(at: indexPath, animated: true)

        switch cell?.textLabel?.text {
        case "Home":
            if let delegate = delegate{
                delegate.closeSideMenu()
            }

        case "Saved Quotes":
            guard let savedQuotesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: SavedQuotesViewController.self)) as? SavedQuotesViewController else {
                return
            }
            savedQuotesViewController.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(savedQuotesViewController, animated: true)

        case "Rate The App":
            StoreKit.SKStoreReviewController.requestReview()

        case "About Stoicism":
            guard let aboutStoicismViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: AboutStoicismViewController.self)) as? AboutStoicismViewController else {
                return
            }
            aboutStoicismViewController.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(aboutStoicismViewController, animated: true)

        default:
            break
        }
    }

}
