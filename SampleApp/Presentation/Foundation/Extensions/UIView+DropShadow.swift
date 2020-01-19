//
//  UIView+DropShadow.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

extension UIView {
    
  func dropShadow(color: UIColor = .black,
                  opacity: Float = 0.3,
                  radius: CGFloat = 4,
                  width: CGFloat = 0,
                  height: CGFloat = 1) {
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = CGSize(width: width, height: height)
    layer.shadowRadius = radius
  }
}
