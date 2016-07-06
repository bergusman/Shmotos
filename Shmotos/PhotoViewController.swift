//
//  PhotoViewController.swift
//  Shmotos
//
//  Created by Vitaly Berg on 06/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var subtypeLabel: UILabel!
    @IBOutlet weak var operationsLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    var asset: PHAsset?
    var image: UIImage?
    
    func resourcesAction() {
        let vc = ResourcesViewController()
        vc.asset = asset
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let asset = asset {
            var items = [String]()
            
            typeLabel.text = asset.mediaType.description
            subtypeLabel.text = asset.mediaSubtypes.description
            
            if asset.sourceType.contains(.TypeNone) {
                items.append("None")
            }
            if asset.sourceType.contains(.TypeUserLibrary) {
                items.append("UserLibrary")
            }
            if asset.sourceType.contains(.TypeCloudShared) {
                items.append("CloudShared")
            }
            if asset.sourceType.contains(.TypeiTunesSynced) {
                items.append("iTunesSynced")
            }
            
            sourceLabel.text = items.joinWithSeparator(", ")
            
            var operations = [String]()
            
            if asset.canPerformEditOperation(.Delete) {
                operations.append("Delete")
            }
            if asset.canPerformEditOperation(.Content) {
                operations.append("Content")
            }
            if asset.canPerformEditOperation(.Properties) {
                operations.append("Properties")
            }
          
            operationsLabel.text = operations.joinWithSeparator(", ")
            
            let options = PHImageRequestOptions()
            options.networkAccessAllowed = true
            options.progressHandler = { progress, error, finish, info in
                dispatch_async(dispatch_get_main_queue(), { 
                    self.progressLabel.text = "\(Int(progress * 100))%"
                })
            }
            
            PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFit, options: options) { (image, info) in
                if let image = image {
                    self.imageView.image = image
                }
            }
            
            let resources = UIBarButtonItem(title: "Resources", style: .Plain, target: self, action: #selector(resourcesAction))
            navigationItem.rightBarButtonItem = resources
            
            print(asset.localIdentifier)
            
        } else if let image = image {
            imageView.image = image
        }
        
        
        
    }

}
