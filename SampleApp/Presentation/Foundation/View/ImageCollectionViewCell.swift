//
//  ImageCollectionViewCell.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit
import ImageCacher

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
        contentView.clipsToBounds = false
        
        contentView.addSubview(imageView)
        imageView.pinToSuperViewEdges()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.dropShadow()
    }
    
    func configure(imageUrl: URL) {
        let placeholderImage = UIImage(named: "broken-image")
        imageView.imgc_loadImage(from: imageUrl, placeholder: placeholderImage)
    }

}
