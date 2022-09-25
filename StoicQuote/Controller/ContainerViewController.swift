import UIKit
import StoreKit

class ContainerViewController: UIViewController , SideMenuDelegate{

    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var mainViewLeading: NSLayoutConstraint!

    let screenWidth : CGFloat = UIScreen.main.bounds.width
    var sideMenuOpen : Bool = false
    let defaults = UserDefaults.standard
    var sideMenuVC: SideMenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGestures()
        isFirstLaunch()
        setNavBarAppearence()
        setupView()
        view.backgroundColor = ColorConstants.lightBackgroundColor
    }

    private func setupView() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        sideMenuVC = storyboard.instantiateViewController(identifier: "SideMenuViewController") as? SideMenuViewController

        if let sideMenuVC = sideMenuVC {
            sideMenuVC.delegate = self
            embed(sideMenuVC, inView: sideMenuView)
        }

    }

    @objc func mainTapped(_ gesture:UITapGestureRecognizer){
        if sideMenuOpen == true {
            closeSideMenu()
        }
    }
    
    @IBAction func sideMenuButtonPressed(_ sender: UIBarButtonItem) {
        if sideMenuOpen {
            closeSideMenu()
        } else {
            openSideMenu()
        }
    }
    
    private func openSideMenu() {
        sideMenuWidth.constant = screenWidth/2
        mainViewLeading.constant = screenWidth/2
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
        sideMenuOpen = true
    }

    func closeSideMenu() {
        sideMenuWidth.constant = 0
        mainViewLeading.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
        sideMenuOpen = false
    }

    func embed(_ viewController:UIViewController, inView view:UIView) {
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }

    func isFirstLaunch() {
        if defaults.bool(forKey: "First Launch") == false {
            guard let firstLaunchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: FirstLaunchViewController.self)) as? FirstLaunchViewController else {
                return
            }
            present(firstLaunchViewController, animated: true)
            defaults.set(true, forKey: "First Launch")
        }
    }
    
    func setNavBarAppearence() {
        let navBarAppearance = UINavigationBarAppearance()
        let attrs = [
            NSAttributedString.Key.font: UIFont(name: "Palatino", size: 24),
            NSAttributedString.Key.foregroundColor: UIColor(ciColor: .black)
        ]

        navBarAppearance.titleTextAttributes = attrs as [NSAttributedString.Key : Any]
        navBarAppearance.backgroundColor = ColorConstants.lightBackgroundColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    
    func setUpGestures() {
        let gestureTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(mainTapped(_:)))

        gestureTapRecognizer.numberOfTapsRequired = 1
        gestureTapRecognizer.numberOfTouchesRequired = 1
        mainView.addGestureRecognizer(gestureTapRecognizer)
        mainView.isUserInteractionEnabled = true
    }

}


