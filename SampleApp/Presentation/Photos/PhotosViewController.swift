//
//  PhotosViewController.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    
    static let CELL_SPACING: CGFloat = 5
    static let LOAD_MORE_THRESHOLD: Int = 6
    
    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let collectionViewDelegate = GridCollectionViewDelegate(numberOfRows: 3, spacing: PhotosViewController.CELL_SPACING)
    let viewModel: PhotosViewModel
    let debouncer = Debouncer(interval: 0.5)
    var loadingView: UIView?
    
    init(viewModel: PhotosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpBindings()
        
        collectionViewDelegate.setOnWillDisplayCellAtIndexPath { [weak self] indexPath in
            guard let `self` = self else { return }
            
            if self.viewModel.photos.count - PhotosViewController.LOAD_MORE_THRESHOLD == indexPath.row {
                self.viewModel.fetchPhotos(search: self.searchBar.text ?? "")
            }
        }
        
        viewModel.fetchPhotos()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageCollectionViewCell.self)", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = viewModel.photos[indexPath.row]
        if let url = URL(string: photo.imageUrl) {
            cell.configure(imageUrl: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else { return UICollectionReusableView() }
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(LoadingCollectionViewFooterView.self)", for: indexPath)
        
        loadingView = footerView
        
        return footerView
    }
    
    // MARK: - SearchBar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouncer.debounce {
            self.viewModel.fetchPhotos(search: searchBar.text ?? "")
        }
    }
    
    // MARK: - Private
    
    private func setUpViews() {
        title = "Photos"
        navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(searchBar)
        searchBar.barTintColor = .lightGray
        searchBar.backgroundColor = .lightGray
        searchBar.backgroundImage = UIImage()
        searchBar.pinToSuperViewEdges(excluding: .bottom)
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        
        view.addSubview(collectionView)
        collectionView.pinToSuperViewEdges(excluding: .top)
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: "\(ImageCollectionViewCell.self)")
        collectionView.register(LoadingCollectionViewFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "\(LoadingCollectionViewFooterView.self)")
        collectionView.contentInset = UIEdgeInsets(top: PhotosViewController.CELL_SPACING * 2,
                                                   left: 0,
                                                   bottom: PhotosViewController.CELL_SPACING * 2,
                                                   right: 0)
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = collectionViewDelegate
    }
    
    private func setUpBindings() {
        viewModel.onPhotosChanged = { [weak self] newPhotos in
            guard let `self` = self else { return }
        
            // When triggering a new search viewModel.photos and newPhotos are empty, reload the collectionView
            guard !self.viewModel.photos.isEmpty || !newPhotos.isEmpty else {
                return self.collectionView.reloadData()
            }
            
            // Animate insertion of new items only
            let difference = self.viewModel.photos.count - newPhotos.count
            let range = (difference..<(difference + newPhotos.count))
            let insertIndexPaths = range.map { IndexPath(row: $0, section: 0) }
            self.collectionView.insertItems(at: insertIndexPaths)
        }
        
        viewModel.isLoading = { [weak self] loading in
            guard let `self` = self else { return }
            
            self.loadingView?.isHidden = !loading
        }
        
        viewModel.onError = { [weak self] error in
            guard let `self` = self else { return }
            
            let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
