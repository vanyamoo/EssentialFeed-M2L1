//
//  UIImageView+Animations.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 10/03/2025.
//

import UIKit

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage

        guard newImage != nil else { return }

        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
