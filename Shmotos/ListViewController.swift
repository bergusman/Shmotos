//
//  ListViewController.swift
//  Shmotos
//
//  Created by Vitaly Berg on 04/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    func setupTableView() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    var list: PHCollectionList?
    var results: [PHFetchResult] = []

    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let result = results[indexPath.section]
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
            cell?.detailTextLabel?.textColor = UIColor.lightGrayColor()
        }
        
        let item = result[indexPath.row] as! PHCollection
        cell!.textLabel!.text = (item.localizedTitle ?? "No name")
        
        
        var info = [String]()
        if item.canContainAssets {
            info.append("assets")
        }
        if item.canContainCollections {
            info.append("collections")
        }
        if let assets = item as? PHAssetCollection {
            info.append(assets.assetCollectionType.description)
            info.append(assets.assetCollectionSubtype.description)
            cell?.textLabel!.text = (cell?.textLabel!.text)! + " — \(assets.estimatedAssetCount)"
        }
        if let list = item as? PHCollectionList {
            info.append(list.collectionListType .description)
            info.append(list.collectionListSubtype.description)
            
        }
        
        cell!.detailTextLabel!.text = info.joinWithSeparator(", ")
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let result = results[indexPath.section]
        
        let item = result[indexPath.row]
        if let list = item as? PHCollectionList {
            let vc = ListViewController()
            vc.list = list
            print(list.localizedLocationNames)
            navigationController?.pushViewController(vc, animated: true)
        } else if let assets = item as? PHAssetCollection {
            let vc = GridViewController()
            vc.assets = assets
            
            print(assets.localizedLocationNames)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupTableView()
        
        if let list = list {
            let options = PHFetchOptions()
            options.includeHiddenAssets = true
            options.includeAssetSourceTypes = [.TypeUserLibrary, .TypeCloudShared, .TypeiTunesSynced]
            let result = PHCollectionList.fetchCollectionsInCollectionList(list, options: options)
            results = [result]
        } else {
            let options = PHFetchOptions()
            options.includeHiddenAssets = true
            options.includeAssetSourceTypes = [.TypeUserLibrary, .TypeCloudShared, .TypeiTunesSynced]
            
            results.append(PHCollectionList.fetchCollectionListsWithType(.Folder, subtype: .Any, options: options))
            results.append(PHCollectionList.fetchCollectionListsWithType(.SmartFolder, subtype: .Any, options: options))
            results.append(PHCollectionList.fetchCollectionListsWithType(.MomentList, subtype: .Any, options: options))
            
            results.append(PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: options))
            results.append(PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .Any, options: options))
            results.append(PHAssetCollection.fetchAssetCollectionsWithType(.Moment, subtype: .Any, options: options))
            
            //let result = PHCollectionList.fetchCollectionListsWithType(.Folder, subtype: .Any, options: options)
            //result = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: options)
        }
        
        // SmartFolder, SmartFolderFaces
        // SmartFolder, SmartFolderEvents
        // Folder, RegularFolder
        // MomentList, MomentListCluster
        // MomentList, MomentListYear
        
        // Moment, AlbumRegular
        // Album, AlbumRegular
        // Album, AlbumCloudShared
        // Album, AlbumMyPhotoStream
 
        
    }

}
