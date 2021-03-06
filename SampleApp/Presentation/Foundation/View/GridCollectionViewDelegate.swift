//
//  GridCollectionViewDelegate.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

class GridCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    typealias OnCellIndexPath = (IndexPath) -> Void
    
    let numberOfColumns: CGFloat
    let spacing: CGFloat
    private var onCellSelected: OnCellIndexPath?
    private var onWillDisplayCellAtIndexPath: OnCellIndexPath?
    
    init(numberOfColumns: CGFloat = 2, spacing: CGFloat = 5) {
        self.numberOfColumns = numberOfColumns
        self.spacing = spacing
    }
    
    func setOnCellSelected(_ onCellSelected: @escaping OnCellIndexPath) {
        self.onCellSelected = onCellSelected
    }
    
    func setOnWillDisplayCellAtIndexPath(_ onWillDisplayCellAtIndexPath: @escaping OnCellIndexPath) {
        self.onWillDisplayCellAtIndexPath = onWillDisplayCellAtIndexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCellSelected?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width / numberOfColumns) - (spacing * 3)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        onWillDisplayCellAtIndexPath?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 96)
    }
}
