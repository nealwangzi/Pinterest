//
//  AnnotatedPhotoCell.swift
//  Pinterest
//
//  Created by neal on 2017/9/5.
//  Copyright © 2017年 neal. All rights reserved.
//

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                captionLabel.text = photo.caption
                commentLabel.text = photo.comment
            }
        }
    }
    
}
