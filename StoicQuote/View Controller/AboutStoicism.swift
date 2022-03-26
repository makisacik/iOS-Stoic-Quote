//
//  WhatIsStoicismViewController.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 22.03.2022.
//

import UIKit

class AboutStoicism: UIViewController {

    @IBOutlet weak var mainText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainText.text = "Stoicism teaches the development of self-control and fortitude as a means of overcoming destructive emotions;\nthe philosophy holds that becoming a clear and unbiased thinker allows one to understand the universal reason."

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
