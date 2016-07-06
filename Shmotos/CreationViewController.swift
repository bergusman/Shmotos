//
//  CreationViewController.swift
//  Shmotos
//
//  Created by Vitaly Berg on 06/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos

class CreationViewController: UIViewController {

    @IBAction func firstAction(sender: AnyObject) {
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ 
            let bingo = PHCollectionListChangeRequest.creationRequestForCollectionListWithTitle("Bingo")
            
            let alpha = PHCollectionListChangeRequest.creationRequestForCollectionListWithTitle("Alpha")
            bingo.addChildCollections([alpha.placeholderForCreatedCollectionList])
            
            let beta = PHCollectionListChangeRequest.creationRequestForCollectionListWithTitle("Beta")
            bingo.addChildCollections([beta.placeholderForCreatedCollectionList])
            
            let gamma = PHCollectionListChangeRequest.creationRequestForCollectionListWithTitle("Gamma")
            beta.addChildCollections([gamma.placeholderForCreatedCollectionList])
            
            let delta = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle("Delta")
            beta.addChildCollections([delta.placeholderForCreatedAssetCollection])
            
            let arnold = PHAssetChangeRequest.creationRequestForAssetFromImage(UIImage(named: "arnold.jpg")!)
            delta.addAssets([arnold.placeholderForCreatedAsset!])
            
            print(arnold.placeholderForCreatedAsset)
            
            if let asset = PHAsset.fetchAssetsWithLocalIdentifiers(["161E1437-171D-4DA4-8D3B-60AD9CEA25AF/L0/001"], options: nil).firstObject as? PHAsset {
                asset.requestContentEditingInputWithOptions(nil, completionHandler: { (input, info) in
                    print(input)
                    print(info)
                    
                    //input?.mediaSubtypes = .PhotoScreenshot
                })
                
            }
            
            //let asset =  arnold.placeholderForCreatedAsset as! PHAsset
            
            /*
            asset.requestContentEditingInputWithOptions(nil, completionHandler: { (input, info) in
                
            })
             
            
 */
            
            }) { (result, error) in
                print(result)
                print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
