//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Roberto Frontado on 15/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let photosVC = PhotosInitializer.create()
        let photosNVC = UINavigationController(rootViewController: photosVC)
        
        let window = UIWindow()
        window.rootViewController = photosNVC
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }

}

