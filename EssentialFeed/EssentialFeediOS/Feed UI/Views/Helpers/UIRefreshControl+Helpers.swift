//
//  UIRefreshControl+Helpers.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 27/03/2025.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
