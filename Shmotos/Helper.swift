//
//  Helper.swift
//  Shmotos
//
//  Created by Vitaly Berg on 05/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import Foundation
import Photos

extension PHAssetCollectionType {
    var description: String {
        switch self {
        case .Album:
            return "Album"
        case .SmartAlbum:
            return "SmartAlbum"
        case .Moment:
            return "Moment"
        }
    }
}

extension PHAssetCollectionSubtype {
    var description: String {
        switch self {
        case .AlbumRegular:
            return "AlbumRegular"
        case .AlbumSyncedEvent:
            return "AlbumSyncedEvent"
        case .AlbumSyncedFaces:
            return "AlbumSyncedFaces"
        case .AlbumSyncedAlbum:
            return "AlbumSyncedAlbum"
        case .AlbumImported:
            return "AlbumImported"
            
        case .AlbumMyPhotoStream:
            return "AlbumMyPhotoStream"
        case .AlbumCloudShared:
            return "AlbumCloudShared"
            
        case .SmartAlbumGeneric:
            return "SmartAlbumGeneric"
        case .SmartAlbumPanoramas:
            return "SmartAlbumPanoramas"
        case .SmartAlbumVideos:
            return "SmartAlbumVideos"
        case .SmartAlbumFavorites:
            return "SmartAlbumFavorites"
        case .SmartAlbumTimelapses:
            return "SmartAlbumTimelapses"
        case .SmartAlbumAllHidden:
            return "SmartAlbumAllHidden"
        case .SmartAlbumRecentlyAdded:
            return "SmartAlbumRecentlyAdded"
        case .SmartAlbumBursts:
            return "SmartAlbumBursts"
        case .SmartAlbumSlomoVideos:
            return "SmartAlbumSlomoVideos"
        case .SmartAlbumUserLibrary:
            return "SmartAlbumUserLibrary"
        case .SmartAlbumSelfPortraits:
            return "SmartAlbumSelfPortraits"
        case .SmartAlbumScreenshots:
            return "SmartAlbumScreenshots"
        case .Any:
            return "Any"
        }
    }
}

extension PHCollectionListType {
    var description: String {
        switch self {
        case .MomentList:
            return "MomentList"
        case .Folder:
            return "Folder"
        case .SmartFolder:
            return "SmartFolder"
        }
    }
}

extension PHCollectionListSubtype {
    var description: String {
        switch self {
        case .MomentListCluster:
            return "MomentListCluster"
        case .MomentListYear:
            return "MomentListYear"
        case .RegularFolder:
            return "RegularFolder"
        case .SmartFolderEvents:
            return "SmartFolderEvents"
        case .SmartFolderFaces:
            return "SmartFolderFaces"
        case .Any:
            return "Any"
        }
    }
}
