//
//  ImageCollectionViewCell.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        contentView.addSubview(imageView)
        imageView.pinToSuperViewEdges()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func configure(imageUrl: URL) {
        imageView.imgc_loadImage(from: imageUrl)
    }

}
