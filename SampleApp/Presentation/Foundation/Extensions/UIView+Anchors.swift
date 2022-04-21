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
    
    @discardableResult
    func pinToSuperViewEdge(edge: Edge, offset: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        return pinToViewEdge(view: superview, edge: edge, offset: offset)
    }
    
    @discardableResult
    func pinToViewEdge(view: UIView, edge: Edge, offset: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint
        
        switch edge {
        case .top:
            constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: offset)
        case .bottom:
            constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
        case .leading:
            constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset)
        case .trailing:
            constraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset)
        }
        
        constraint.isActive = true
        return constraint
    }

}
