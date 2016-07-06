//
//  ResourcesViewController.swift
//  Shmotos
//
//  Created by Vitaly Berg on 06/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos

class ResourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var asset: PHAsset?
    var resources: [PHAssetResource] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let resource = resources[indexPath.row]
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
            cell?.detailTextLabel?.textColor = UIColor.lightGrayColor()
        }
        
        if let cell = cell {
            cell.textLabel!.text = resource.originalFilename
            cell.detailTextLabel!.text = resource.type.description + ", " + resource.uniformTypeIdentifier
        }
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let resource = resources[indexPath.row]
        
        let options = PHAssetResourceRequestOptions()
        options.networkAccessAllowed = true
        options.progressHandler = { progress in
            print(progress)
        }
        
        PHAssetResourceManager.defaultManager().requestDataForAssetResource(resource, options: options, dataReceivedHandler: { (data) in
            if resource.uniformTypeIdentifier == "public.jpeg" {
                let image = UIImage(data: data)
                dispatch_async(dispatch_get_main_queue(), {
                    if let image = image {
                        let vc = PhotoViewController()
                        vc.image = image
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                })
                
            } else if resource.type == .AdjustmentData {
                let s = NSString(data: data, encoding: NSUTF8StringEncoding)
                print(s)
            }
            
            }) { (error) in
                print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let asset = asset {
            resources = PHAssetResource.assetResourcesForAsset(asset)
        }
    }
    
}
