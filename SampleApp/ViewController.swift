//
//  ViewController.swift
//  SampleApp
//
//  Created by Roberto Frontado on 15/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit
import ImageCacher

class ViewController: UIViewController {

    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        imageView.backgroundColor = .red
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        let urlString = "https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png"
        guard let url = URL(string: urlString) else { return }
        
        imageView.imgc_loadImage(from: url) { print("Image: \($0)") }
    }
}

