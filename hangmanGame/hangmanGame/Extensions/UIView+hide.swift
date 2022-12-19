//
//  UIView+hide.swift
//  hangmanGame
//
//  Created by Daria Sechko on 17.12.22.
//

import UIKit

extension UIView {
    
    func hide() {
        guard !isHidden else { return }
        isHidden = true
    }
    
    func show() {
        guard isHidden else { return }
        isHidden = false
    }
}
