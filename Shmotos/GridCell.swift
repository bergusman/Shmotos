//
//  GridCell.swift
//  Shmotos
//
//  Created by Vitaly Berg on 04/07/16.
//  Copyright © 2016 Bingo. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var upImageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    // MARK: - Nibbing

    class var nib: UINib {
        get {
            return UINib(nibName: "GridCell", bundle: nil)
        }
    }
    
}
