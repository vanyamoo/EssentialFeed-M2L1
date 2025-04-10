//
//  UIView+TestHelpers.swift
//  EssentialApp
//
//  Created by Vanya Mutafchieva on 10/04/2025.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
