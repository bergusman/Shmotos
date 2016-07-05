//
//  GridViewController.swift
//  Shmotos
//
//  Created by Vitaly Berg on 04/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos

class GridViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    func setupCollectionView() {
        collectionView.registerNib(GridCell.nib, forCellWithReuseIdentifier: "cell")
    }
    
    var assets: PHAssetCollection?
    var result: PHFetchResult!
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! GridCell
        let asset = result[indexPath.item] as! PHAsset
        
        /*
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: cell.bounds.size, contentMode: .AspectFill, options: nil) { (image, info) in
            cell.imageView.image = image
        }
 */
        
        let options = PHImageRequestOptions()
        options.version = .Current
        //options.networkAccessAllowed = true
        options.deliveryMode = .Opportunistic
        options.resizeMode = .None
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSizeMake(400, 400), contentMode: .AspectFill, options: options) { (image, info) in
            if let image = image {
                print("\(image.size) \(image.scale)")
                cell.imageView.image = image
            }
            
        }
        return cell
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        result = PHAsset.fetchAssetsInAssetCollection(assets!, options: nil)
        navigationItem.title = String(result.count)
    }

}
