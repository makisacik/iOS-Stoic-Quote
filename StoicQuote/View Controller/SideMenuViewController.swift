//
//  SideMenuViewController.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 14.10.2021.
//

import UIKit
import StoreKit

protocol SideMenuDelegate {
    func performSegueToSaved()
    func closeSideMenu()
    func performSegueToAboutStoicism()
}

class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    enum MenuButtons:String,CaseIterable{
        case home = "Home"
        case savedQuotes = "Saved Quotes"
        case whatIsStoicism = "About Stoicism"
        case rateApp = "Rate The App"
   
        var imageName: String{
            switch self {
            case .home:
                return "house"
            case .savedQuotes:
                return "bookmark"
            case .whatIsStoicism:
                return "questionmark"
            case .rateApp:
                return "star"
            }
        }
    }
        
    @IBOutlet weak var menuTable: UITableView!
    
    var delegate : SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.dataSource  = self
        menuTable.delegate = self
        menuTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        menuTable.tableFooterView = UIView.init(frame: CGRect.zero)
        menuTable.backgroundColor = UIColor(red: 238/255, green: 228/255, blue: 216/255, alpha: 1)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuButtons.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuButtons.allCases[indexPath.row].rawValue
        cell.textLabel?.font = UIFont(name: "System", size: 15)
        cell.imageView?.image = UIImage(systemName: MenuButtons.allCases[indexPath.row].imageName)
        // color of the icons
        cell.imageView?.tintColor = .init(red: CGFloat(130/255) , green: CGFloat(124/255), blue: CGFloat(119/255), alpha: 1)
        //cells background
        cell.backgroundColor = UIColor(red: 238/255, green: 228/255, blue: 216/255, alpha: 1)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        cell.textLabel?.adjustsFontSizeToFitWidth = true


        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = menuTable.cellForRow(at: indexPath)
        menuTable.deselectRow(at: indexPath, animated: true)
        switch cell?.textLabel?.text {
        case "Home":
            if let delegate = delegate{
                delegate.closeSideMenu()
            }
        case "Saved Quotes":
            if let delegate = delegate{
                delegate.performSegueToSaved()
            }
        case "Rate The App":
            StoreKit.SKStoreReviewController.requestReview()
        case "About Stoicism":
            delegate?.performSegueToAboutStoicism()
        default:
            break
        }
        
    }
}
