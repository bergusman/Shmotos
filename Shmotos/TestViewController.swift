//
//  TestViewController.swift
//  Shmotos
//
//  Created by Vitaly Berg on 06/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos

class TestViewController: UIViewController {

    @IBAction func alphaAction(sender: AnyObject) {
        
        for _ in 0..<1000 {
            let result = PHCollection.fetchTopLevelUserCollectionsWithOptions(nil)
            for i in 0..<result.count {
                let collection = result[i] as! PHCollection
                if let assets = collection as? PHAssetCollection {
                    let options = PHFetchOptions()
                    //options.fetchLimit = 1
                    let assetsResult = PHAsset.fetchAssetsInAssetCollection(assets, options: options)
                    
                    
                    /*
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        let assetsResult = PHAsset.fetchAssetsInAssetCollection(assets, options: nil)
                    })
                    */
                    
                }
            }
        }
        
        
        // 16300
        // 21300
        
        // fetchLimit decrease time for 25%
        
        
    }
    
    @IBAction func betaAction(sender: AnyObject) {
        for _ in 0..<1000 {
            let result = PHAsset.fetchAssetsWithOptions(nil)
            let objects = result.objectsAtIndexes(NSIndexSet(indexesInRange: NSMakeRange(0, result.count - 1)))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
