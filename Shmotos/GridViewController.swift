//
//  GridViewController.swift
//  Shmotos
//
//  Created by Vitaly Berg on 04/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos

class GridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    func setupCollectionView() {
        collectionView.registerNib(GridCell.nib, forCellWithReuseIdentifier: "cell")
    }
    
    var asset: PHAsset?
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
        
        cell.upImageView.backgroundColor = UIColor.clearColor()
        
        if asset.representsBurst {
            cell.upImageView.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.4)
        }
        if asset.favorite {
            cell.upImageView.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.4)
        }
        if asset.hidden {
            cell.upImageView.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.4)
        }
        
        let options = PHImageRequestOptions()
        options.version = .Current
        //options.networkAccessAllowed = true
        //options.deliveryMode = .Opportunistic
        //options.resizeMode = .None
        
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSizeMake(200, 200), contentMode: .AspectFill, options: options) { (image, info) in
            if let image = image {
                print("\(image.size) \(image.scale)")
                cell.imageView.image = image
            }
        }
        
        let resources = PHAssetResource.assetResourcesForAsset(asset)
        cell.label.text = String(resources.count)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        let asset = result[indexPath.item] as! PHAsset
        if asset.representsBurst && asset.localIdentifier != self.asset?.localIdentifier {
            let vc = GridViewController()
            vc.asset = asset
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = PhotoViewController()
            vc.asset = asset
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        if let assets = assets {
            result = PHAsset.fetchAssetsInAssetCollection(assets, options: nil)
            navigationItem.title = String(result.count)
        } else if let asset = asset {
            let options = PHFetchOptions()
            options.includeAllBurstAssets = true
            result = PHAsset.fetchAssetsWithBurstIdentifier(asset.burstIdentifier!, options: options)
            navigationItem.title = String(result.count)
        }
        
        if result.count > 0 {
            //let indexPath = NSIndexPath(forItem: result.count - 1, inSection: 0)
            //collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}
