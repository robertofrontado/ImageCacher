//
//  PhotosViewController.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDataSource {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let collectionViewDelegate = GridCollectionViewDelegate(numberOfRows: 3, spacing: 5)
    let viewModel: PhotosViewModel
    
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
    
    // MARK: - Private
    
    private func setUpViews() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = collectionViewDelegate
        
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: "\(ImageCollectionViewCell.self)")
    }
    
    private func setUpBindings() {
        viewModel.onPhotosChanged = { [weak self] in
            guard let `self` = self else { return }
            self.collectionView.reloadData()
        }
        
        viewModel.isLoading = { [weak self] loading in
            guard let `self` = self else { return }
            // TODO: - Add implementation
        }
        
        viewModel.onError = { [weak self] error in
            guard let `self` = self else { return }
            // TODO: - Add implementation
        }
    }
}
