//
//  UITableView+Dequeueing.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 10/03/2025.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
