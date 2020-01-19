//
//  DisplayAnimations.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 19/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

public typealias DisplayAnimation = (_ imageView: UIImageView, _ newImage: UIImage, _ duration: TimeInterval) -> Void

public struct Animations {
    
    public static let `none`: DisplayAnimation = { imageView, newImage, duration in
        imageView.image = newImage
    }
    
    public static let crossDissolve: DisplayAnimation = getDisplayAnimationWithOptions(.transitionCrossDissolve)
    
    private static func getDisplayAnimationWithOptions(_ options: UIView.AnimationOptions = []) -> DisplayAnimation {
        return { imageView, newImage, duration in
            UIView.transition(with: imageView, duration: duration, options: options, animations: {
                imageView.image = newImage
            })
        }
    }
}
