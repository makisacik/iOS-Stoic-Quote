//
//  UIView+Extensions.swift
//  StoicQuote
//
//  Created by Mehmet Ali Kısacık on 24.09.2022.
//

import Foundation
import UIKit

extension UIView {

    func fadeInOut(fadeInDuration: TimeInterval = 0.2, fadeOutDuration: TimeInterval = 0.03){
        fadeOut(duration: fadeOutDuration) { [weak self] _ in
            self?.fadeIn(duration: fadeInDuration)
        }
    }

    private func fadeIn(duration: TimeInterval, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    private func fadeOut(duration: TimeInterval, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0.5
        }, completion: completion)
    }

}
