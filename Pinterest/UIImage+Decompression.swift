//
//  UIImage+Decompression.swift
//  Pinterest
//
//  Created by neal on 2017/9/5.
//  Copyright © 2017年 neal. All rights reserved.
//

import UIKit

extension UIImage {
    
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint.zero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage!
    }
    
}
