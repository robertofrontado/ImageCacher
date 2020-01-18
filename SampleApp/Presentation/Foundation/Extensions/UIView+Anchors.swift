//
//  UIView+Anchors.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

enum Edge {
    case top
    case bottom
    case leading
    case trailing
}

extension UIView {
    
    @discardableResult
    func pinToSuperViewEdges(offsetX: CGFloat = 0, offsetY: CGFloat = 0, excluding edge: Edge? = nil) -> [NSLayoutConstraint] {
        guard let superview = superview?.safeAreaLayoutGuide else { return [] }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if edge != .top {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: offsetY).isActive = true
        }
        if edge != .bottom {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -offsetY).isActive = true
        }
        if edge != .leading {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: offsetX).isActive = true
        }
        if edge != .trailing {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -offsetX).isActive = true
        }
        
        return constraints
    }

}
