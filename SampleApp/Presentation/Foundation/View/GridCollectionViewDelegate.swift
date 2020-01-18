//
//  GridCollectionViewDelegate.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

class GridCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    typealias OnCellSelected = (IndexPath) -> Void
    
    let numberOfRows: CGFloat
    let spacing: CGFloat
    private var onCellSelected: OnCellSelected?
    
    init(numberOfRows: CGFloat = 2, spacing: CGFloat = 5) {
        self.numberOfRows = numberOfRows
        self.spacing = spacing
    }
    
    func setOnCellSelected(_ onCellSelected: @escaping OnCellSelected) {
        self.onCellSelected = onCellSelected
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCellSelected?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width / numberOfRows) - (spacing * 3)
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: spacing * 2, bottom: 0, right: spacing * 2)
    }
}
