//
//  AppDelegate.swift
//  Shmotos
//
//  Created by Vitaly Berg on 04/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // TODO: see bursts
    // TODO: more info about assets
    // TODO: actions with collections
    // TODO: changing collections and assets

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        let vc = ListViewController()
        let nc = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = nc
        
        let result = PHAsset.fetchAssetsWithOptions(nil)
        print(result.count)
        
        return true
    }

}

