import UIKit
import StoreKit
class ContainerViewController: UIViewController , SideMenuDelegate{

    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    
    @IBOutlet weak var mainViewLeading: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    
    let screenWidth : CGFloat = UIScreen.main.bounds.width
    var sideMenuOpen : Bool = false
    
    let defaults = UserDefaults.standard
    
    var sideMenuVC:SideMenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGestures()
        isFirstLaunch()
        setNavBarAppearence()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        sideMenuVC = storyboard.instantiateViewController(identifier: "SideMenuViewController") as? SideMenuViewController
        
        sideMenuVC?.delegate = self
        
        embed(sideMenuVC!, inView: sideMenuView)
    }

    
    //MARK: - BUTTON FUNCS
    @objc func mainTapped(_ gesture:UITapGestureRecognizer){
        if sideMenuOpen == true {
            closeSideMenu()
        }
    }
    
    @IBAction func sideMenuButtonPressed(_ sender: UIBarButtonItem) {
        if sideMenuOpen {
            closeSideMenu()
        }
        else{
            openSideMenu()
        }
    }
    
    //MARK: - SIDE MENU FUNCS
    private func openSideMenu(){
        sideMenuWidth.constant = screenWidth/2
        mainViewLeading.constant = screenWidth/2
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        sideMenuOpen = true
    }

    func closeSideMenu(){
        sideMenuWidth.constant = 0
        mainViewLeading.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        sideMenuOpen = false
    }
    
    //MARK: - SEGUES
    
    func performSegueToSaved() {
        performSegue(withIdentifier: "testSegue", sender: self)
    }
    
    func performSegueToAboutStoicism() {
        performSegue(withIdentifier: "WhatIsSegue", sender: self)
    }

    
    
    //MARK: - OTHER FUNCS
    func isFirstLaunch(){
        if defaults.bool(forKey: "First Launch") == true {
            defaults.set(false, forKey: "First Launch")
        }
        else{
            performSegue(withIdentifier: "PopUpSegue", sender: self)
            defaults.set(true, forKey: "First Launch")
        }
    }
    
    
    func setNavBarAppearence(){
        let navBarAppearance = UINavigationBarAppearance()
        let attrs = [
            NSAttributedString.Key.font: UIFont(name: "Palatino", size: 24)!
        ]
        navBarAppearance.backgroundColor = UIColor(red: 247/255, green: 237/255, blue: 226/255, alpha: 1)
        navBarAppearance.titleTextAttributes = attrs
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 247/255, green: 237/255, blue: 226/255, alpha: 1)
    }
    
    
    func setUpGestures(){
        let gestureTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(mainTapped(_:)))
        
        gestureTapRecognizer.numberOfTapsRequired = 1
        gestureTapRecognizer.numberOfTouchesRequired = 1
        
        mainView.addGestureRecognizer(gestureTapRecognizer)
        mainView.isUserInteractionEnabled = true
    }
    

}


extension ContainerViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
