//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 27/02/2025.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
