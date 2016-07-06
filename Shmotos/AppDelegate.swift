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
        nc.tabBarItem.title = "List"
        
        let mvc = MapViewController()
        let mnc = UINavigationController(rootViewController: mvc)
        mnc.tabBarItem.title = "Map"
        
        let cvc = CreationViewController()
        let cnc = UINavigationController(rootViewController: cvc)
        cnc.tabBarItem.title = "Creation"
        
        let tbc = UITabBarController()
        tbc.viewControllers = [nc, mnc, cnc]
        
        window?.rootViewController = tbc
        
        return true
    }

}

