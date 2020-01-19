//
//  ImageCacherAnimation.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 19/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

public typealias ImageCacherAnimation = (_ imageView: UIImageView, _ newImage: UIImage, _ duration: TimeInterval) -> Void

public struct ImageCacherAnimations {
    
    public static let `none`: ImageCacherAnimation = { imageView, newImage, duration in
        imageView.image = newImage
    }
    
    public static let crossDissolve: ImageCacherAnimation = getAnimationWithOptions(.transitionCrossDissolve)
    
    private static func getAnimationWithOptions(_ options: UIView.AnimationOptions = []) -> ImageCacherAnimation {
        return { imageView, newImage, duration in
            UIView.transition(with: imageView, duration: duration, options: options, animations: {
                imageView.image = newImage
            })
        }
    }
}
