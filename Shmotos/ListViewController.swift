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
    var titles: [String] = []

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
            if assets.estimatedAssetCount != NSNotFound {
                cell?.textLabel!.text = (cell?.textLabel!.text)! + " — \(assets.estimatedAssetCount)"
            }
            
        }
        if let list = item as? PHCollectionList {
            info.append(list.collectionListType .description)
            info.append(list.collectionListSubtype.description)
        }
        
        var operations = [String]()
        
        if item.canPerformEditOperation(.AddContent) {
            operations.append("AC")
        }
        if item.canPerformEditOperation(.CreateContent) {
            operations.append("CC")
        }
        if item.canPerformEditOperation(.DeleteContent) {
            operations.append("DC")
        }
        if item.canPerformEditOperation(.RemoveContent) {
            operations.append("RC")
        }
        if item.canPerformEditOperation(.RearrangeContent) {
            operations.append("MC")
        }
        if item.canPerformEditOperation(.Delete) {
            operations.append("D")
        }
        if item.canPerformEditOperation(.Rename) {
            operations.append("R")
        }
        
        cell!.detailTextLabel!.text = info.joinWithSeparator(", ") + (operations.count > 0 ? ", " : "")  + operations.joinWithSeparator(" ")
        
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
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        } else if let assets = item as? PHAssetCollection {
            let vc = GridViewController()
            vc.assets = assets
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if titles.count > 0 {
            return titles[section]
        }
        return nil
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
            
            titles = ["Folders", "Smart Folders", "Moment Lists", "Albums", "Smart Albums", "Moments"]
            
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
