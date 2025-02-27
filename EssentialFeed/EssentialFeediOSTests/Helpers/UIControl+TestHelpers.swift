//
//  UIControl+TestHelpers.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 27/02/2025.
//

import UIKit


extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
