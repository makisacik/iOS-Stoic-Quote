//
//  UIView+Extensions.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 23.09.2022.
//

import Foundation
import UIKit

extension UIButton {

    func setImageBookmark() {
        self.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }

    func setImageBookmarkFill() {
        self.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
    }

}
