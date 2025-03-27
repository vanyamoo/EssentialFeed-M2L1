//
//  ErrorView.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 27/03/2025.
//

import UIKit

public final class ErrorView: UIView {
    @IBOutlet private var label: UILabel!

        public var message: String? {
            get { return label.text }
            set { label.text = newValue }
        }

        public override func awakeFromNib() {
            super.awakeFromNib()

            label.text = nil
        }
}
