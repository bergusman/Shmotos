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

extension PHAssetResourceType {
    var description: String {
        switch self {
        case .Photo:
            return "Photo"
        case .Video:
            return "Video"
        case .Audio:
            return "Audio"
        case .AlternatePhoto:
            return "AlternatePhoto"
        case .FullSizePhoto:
            return "FullSizePhoto"
        case .FullSizeVideo:
            return "FullSizeVideo"
        case .AdjustmentData:
            return "AdjustmentData"
        case .AdjustmentBasePhoto:
            return "AdjustmentBasePhoto"
        case .PairedVideo:
            return "PairedVideo"
        }
    }
}

extension PHAssetMediaType {
    var description: String {
        switch self {
        case .Unknown:
            return "Unknown"
        case .Image:
            return "Image"
        case .Video:
            return "Video"
        case .Audio:
            return "Audio"
        }
    }
}

extension PHAssetMediaSubtype {
    var description: String {
        var items = [String]()
        
        if self.contains(.None) {
            items.append("None")
        }
        if self.contains(.PhotoPanorama) {
            items.append("PhotoPanorama")
        }
        if self.contains(.PhotoHDR) {
            items.append("PhotoHDR")
        }
        if self.contains(.PhotoScreenshot) {
            items.append("PhotoScreenshot")
        }
        if self.contains(.PhotoLive) {
            items.append("PhotoLive")
        }
        if self.contains(.VideoStreamed) {
            items.append("VideoStreamed")
        }
        if self.contains(.VideoHighFrameRate) {
            items.append("VideoHighFrameRate")
        }
        if self.contains(.VideoTimelapse) {
            items.append("VideoTimelapse")
        }
        
        return items.joinWithSeparator(", ")
    }
}
